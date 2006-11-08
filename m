Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWKHQgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWKHQgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWKHQgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:36:42 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:13769 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1161205AbWKHQgm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:36:42 -0500
To: hch@infradead.org
CC: Martin.Weber@cern.ch, linux-kernel@vger.kernel.org
In-reply-to: <20061108161232.GA19284@infradead.org> (message from Christoph
	Hellwig on Wed, 8 Nov 2006 16:12:32 +0000)
Subject: Re: kernel BUG at include/linux/dcache.h:303
References: <200611081708.43932.Martin.Weber@cern.ch> <20061108161232.GA19284@infradead.org>
Message-Id: <E1GhqOq-0001MA-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 08 Nov 2006 17:35:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > found the following message (see attached file), shortly after the system 
> > died...
> > 
> > Kind regards,
> > 
> > Martin
> 
> > VFS: Busy inodes after unmount of shfs. Self-destruct in 5 seconds.  Have a nice day...
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/dcache.h:303!
> > invalid opcode: 0000 [#1]
> > PREEMPT
> > Modules linked in: shfs radeon drm ipw2100 joydev
> > CPU:    0
> > EIP:    0060:[<c0169b6d>]    Tainted: P      VLI
> 
> Whatever propritary module shfs is it's most likely the cause.
> Please try again without it.

While not propritary, shfs _is_ severely broken.  Try sshfs instead
which provides similar functionality:

  http://fuse.sourceforge.net/sshfs.html

Miklos
