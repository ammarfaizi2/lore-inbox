Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265331AbSJRRcA>; Fri, 18 Oct 2002 13:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265344AbSJRR10>; Fri, 18 Oct 2002 13:27:26 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:43516 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265331AbSJRRGm>; Fri, 18 Oct 2002 13:06:42 -0400
Date: Fri, 18 Oct 2002 10:05:54 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <20021015100024.A9771@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210180951500.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure this "set var" business has been thought out as much as it
> should be.

<snip>

   I see it coming. With the next set of changes it will be possible to
have fbdev with the VT system. So I have been putting into place the
ability to power down the framebuffer via the ioctl. So I want the flow
to be with fbcon from high level console to fbcon layer to fbdev driver.
Without fbcon to go from userland to the fbdev driver directly.
   Also we have mode changing. Soon I will add hooks to the VT layer to
allow use to change a single VC via stty. VT_RESIZE can replace the
current method of changing the size of all VCS instead of the fbdev layer
doing it.
   So you will see the necessary changes to handle all this.

