Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRC0U3a>; Tue, 27 Mar 2001 15:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131545AbRC0U3U>; Tue, 27 Mar 2001 15:29:20 -0500
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:60343 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131544AbRC0U3H>; Tue, 27 Mar 2001 15:29:07 -0500
Date: Tue, 27 Mar 2001 12:29:28 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <linas@linas.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problems in 2.4.2 -> lost byte
Message-ID: <Pine.LNX.4.31.0103271226140.847-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This is easily explained: some byte of the mouse protocol was lost.
>(Some mouse protocols are even designed to allow
>easy resync/recovery by fixed bit patterns!)
>
>Write an intelligent mouse driver for XFree86 to compensate for
>lost bytes.

Or write a kernel input device driver. In fact I probable have a mouse
driver for you. What kind of mouse do you have? Then set your X config to
have the following:

Section "Pointer"
            Protocol    "ImPS/2"
            Device      "/dev/input/mice"
            ZAxisMapping 4 5
EndSection

This way you don't have to wait a few months before the bug is fixed by
XFree86.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

