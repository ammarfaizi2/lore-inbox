Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbSJ2Tph>; Tue, 29 Oct 2002 14:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJ2Tph>; Tue, 29 Oct 2002 14:45:37 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:19192 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262295AbSJ2Tpf>; Tue, 29 Oct 2002 14:45:35 -0500
Date: Tue, 29 Oct 2002 12:45:10 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [BK updates] fbdev changes updates.
Message-ID: <Pine.LNX.4.33.0210291240170.14451-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!!!

   Here are the last series of fbdev changes. The console layer code has
been removed from the low level drivers. This it is possible to run fbdev
without the VT console system or with it using a different driver. I did
this with the VESA fbdev driver and MDA con!!!! This will save so much
time testing future fbdev drivers.
    I also moved the agp and drm code over to drivers/video. The reason I
did this was to support fbdev drivers that will be strickly DMA/AGP
based. The reason for this is we will see in the future embedded ix86
boards with things like i810 framebuffers with NO vga core. In this case
we will need a fbdev driver for a graphical console. Thus the agp code
must be started before the fbdev layer.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

