Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423093AbWJRWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423093AbWJRWYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423095AbWJRWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:24:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423093AbWJRWYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:24:10 -0400
Date: Wed, 18 Oct 2006 15:23:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cedric Le Goater <clg@fr.ibm.com>, Carsten Otte <cotte@freenet.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018152346.0486b6bc.akpm@osdl.org>
In-Reply-To: <45368E0A.1030503@fr.ibm.com>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<45367210.4040507@googlemail.com>
	<200610182118.31371.rjw@sisk.pl>
	<4536818E.3060505@fr.ibm.com>
	<453683A6.9090106@yahoo.com.au>
	<45368E0A.1030503@fr.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 22:26:50 +0200
Cedric Le Goater <clg@fr.ibm.com> wrote:

> > Because we must service a fault if it happens here. The
> > fault_in_pages_readable and comments are wrong AFAIKS.
> 
> hmm. It says :
> 
> 		/*
> 		 * Bring in the user page that we will copy from _first_.
> 		 * Otherwise there's a nasty deadlock on copying from the
> 		 * same page as we're writing to, without it being marked
> 		 * up-to-date.
> 		 */
> 
> How can we improve it ? 

The page we're writing into isn't locked, so there's no deadlock afaict.

But then, I forget how xip works.  Carsten, is it actually being used for
anything?

