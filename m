Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264351AbUAITy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUAITy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:54:56 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:54026 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264351AbUAITyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:54:55 -0500
Date: Fri, 9 Jan 2004 19:54:50 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New FBDev patch
In-Reply-To: <20040108232621.B25760@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is the latest patch against 2.6.0-rc3. Give it a try.
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> This looks wrong (cyber2000fb.c):

Yeap it is. Typo. 

> sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
> inside cfb_info, and dispense with this addition here.

You have to make sure the struct fb_info pseudopalette points to the data 
in cfb_info. Actually only drivers should allocate the pseudopalette at 
boot time if the hardware doesn't support mode change. In the other case 
the pseudopalette should be allocated in set_par. 


