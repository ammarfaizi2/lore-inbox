Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbTCYDI2>; Mon, 24 Mar 2003 22:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbTCYDI1>; Mon, 24 Mar 2003 22:08:27 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:65032 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261381AbTCYDIY>; Mon, 24 Mar 2003 22:08:24 -0500
Date: Tue, 25 Mar 2003 03:19:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Toplica Tanaskovic <toptan@EUnet.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
In-Reply-To: <200303250255.10510.toptan@EUnet.yu>
Message-ID: <Pine.LNX.4.44.0303250313520.22808-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	I've encountered two reproducable bugs, and one feature which can and can not 
> be called bug:
> 
> 1. Radeon frame buffer driver doesn't support mode change in kernel boot 
> params. In 2.6.65 it is OK.
> 
> 	append line from lilo.conf
> 
>     append = " hdd=ide-scsi video=radeon:1024x768-24@100"
> 
> 	No mether what is in video=radeon:..., resolution is always set to 80x30 with 
> 60Hz refresh.

Its radeonfb now instead of radeon. Alot of drivers where broken in this 
way. Now every driver follows a standard.

> 2. Radeon frame buffer mode switching gives unexpected results. When switching 
> from lower res to higher, switching is ok but you still have old chararcter 
> res. eg. 80x30. The text is located in upper left corner, and the right side 
> off the text area is filled with garbage. Bellow text area there is nothing.

For console resizing try using stty cols xxx rows xx.

Fbset hasn't been updated to the new changes yet. I plan to fix up fbset 
and also maybe stty. The tty layer can work on the pixel level. See struct 
winsize in asm/termios.h
 	
> 3. Cursor disapears when moving with cursor keys. This is very annoying when 
> you are editing text for example.
> 
> 	My config is attached, gcc version is 2.95.3, modutils 2.4.21.

I didn't notice this. I will track it down.


