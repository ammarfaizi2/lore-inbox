Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbSLWUej>; Mon, 23 Dec 2002 15:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSLWUej>; Mon, 23 Dec 2002 15:34:39 -0500
Received: from rth.ninka.net ([216.101.162.244]:17554 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S266970AbSLWUej>;
	Mon, 23 Dec 2002 15:34:39 -0500
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0212231014460.12134-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0212231014460.12134-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Dec 2002 13:11:43 -0800
Message-Id: <1040677903.21606.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 01:18, Geert Uytterhoeven wrote:
> That's because originally there was no fix.line_length field, and the line
> length was derived from var.xres_virtual and var.bits_per_pixel.
> 
> With some hardware, the line length must be a multiple of 32 or 64 bits, and we
> needed a way to specify that, so fix.line_length was introduced. If it was
> zero, user code should fallback to the old behavior.

And with some cards, the line length is constant.  Ie. to get to
"X, Y + 1" for a given "X, Y" you add a constant to your current
frame buffer pointer.

That is what fix.line_length is for right?

