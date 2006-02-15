Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946046AbWBORb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946046AbWBORb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946049AbWBORby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:31:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:53683 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1946046AbWBORby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:31:54 -0500
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43F34ED5.8020306@cfl.rr.com>
References: <m3lkwg4f25.fsf@telia.com>
	 <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
	 <43F0B8FC.6020605@cfl.rr.com>
	 <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
	 <43F1FD39.1040900@cfl.rr.com>
	 <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com>
	 <43F34ED5.8020306@cfl.rr.com>
Date: Wed, 15 Feb 2006 19:31:48 +0200
Message-Id: <1140024709.24898.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 10:55 -0500, Phillip Susi wrote:
> Maybe I should amend the patch to work like this:
> 
> uid/gid : specify default id when -1 is on disk
> uid/gid = force : ignore ids on disk
> uid/gid = [no]save : do [not] save actual id to disk ( save -1 instead )
> 
> Possibly with nosave being the default.  Would this be more acceptable?

Yeah, sounds much better to me. However, I am wondering if we can
actually drop the nosave/save cases completely. Wouldn't we get the same
semantics by letting uid/gid specify the default id and make the ignore
case look like we're always reading -1 from disk, and never writing out
any ids? So as a desktop user, you mount with "uid=", "gid=", and
"force" passed as mount option and it works as expected.

			Pekka

