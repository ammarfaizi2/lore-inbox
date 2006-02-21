Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWBUXiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWBUXiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBUXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:38:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWBUXiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:38:08 -0500
Date: Tue, 21 Feb 2006 15:33:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kay Sievers <kay.sievers@suse.de>
Cc: penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060221153305.5d0b123f.akpm@osdl.org>
In-Reply-To: <20060221225718.GA12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<20060217231444.GM4422@stusta.de>
	<84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	<20060219145442.GA4971@stusta.de>
	<1140383653.11403.8.camel@localhost>
	<20060220010205.GB22738@suse.de>
	<1140562261.11278.6.camel@localhost>
	<20060221225718.GA12480@vrfy.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@suse.de> wrote:
>
> On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> > On Sun, 2006-02-19 at 17:02 -0800, Greg KH wrote:
> > > If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> > > start working for you again?
> > 
> > Okey dokey, bisecting with mrproper took little longer than expected but
> > I found the bad changeset:

Thanks - it helps heaps.

> > 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> > diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> > Author: Kay Sievers <kay.sievers@suse.de>
> > Date:   Fri Nov 11 06:09:55 2005 +0100
> > 
> >     [PATCH] remove mount/umount uevents from superblock handling
> 
> Upgrade HAL, it's too old for that kernel.
> 

We broke back-compatibility.  The changelog _failed to tell us_ that we
were breaking back-compatibility.  The patch wouldn't have been applied if
we'd been told that.  At least, not without a lot of careful thought.

The fact that the changelog failed to tell us this makes one suspect that
the breakage was inadvertent.


So no, upgrading HAL is not a good answer.  Please fix the kernel.


