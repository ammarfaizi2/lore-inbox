Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWBOStW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWBOStW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBOStW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:49:22 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:21174 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750734AbWBOStW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:49:22 -0500
Message-ID: <43F37773.5030203@cfl.rr.com>
Date: Wed, 15 Feb 2006 13:48:19 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
References: <m3lkwg4f25.fsf@telia.com> <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com> <43F0B8FC.6020605@cfl.rr.com> <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI> <43F1FD39.1040900@cfl.rr.com> <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com> <43F34ED5.8020306@cfl.rr.com> <1140024709.24898.7.camel@localhost>
In-Reply-To: <1140024709.24898.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 18:50:57.0906 (UTC) FILETIME=[C1F6BD20:01C63260]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--1.850000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Yeah, sounds much better to me. However, I am wondering if we can
> actually drop the nosave/save cases completely. Wouldn't we get the same
> semantics by letting uid/gid specify the default id and make the ignore
> case look like we're always reading -1 from disk, and never writing out
> any ids? So as a desktop user, you mount with "uid=", "gid=", and
> "force" passed as mount option and it works as expected.

True, that would work.  It would require the addition of another mount 
option though, so I wonder, is that really needed?  What problem with 
the current patch would this solve?  Is there really a need to save real 
ids to the disk with the current uid option and no force?  Keep in mind 
that udf is meant for removable media where the uids aren't going to 
make any sense in another system.


Maybe I'm just being lazy though... I'll dig back into it and try to 
submit a new patch with the force option by this weekend.

