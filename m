Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSLWLKi>; Mon, 23 Dec 2002 06:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSLWLKi>; Mon, 23 Dec 2002 06:10:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261529AbSLWLKi>; Mon, 23 Dec 2002 06:10:38 -0500
Date: Mon, 23 Dec 2002 11:18:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
Message-ID: <20021223111840.A20948@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Antonino Daplas <adaplas@pol.net>,
	James Simmons <jsimmons@infradead.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <20021221092744.A23531@flint.arm.linux.org.uk> <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0212231004040.12134-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Mon, Dec 23, 2002 at 10:07:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 10:07:35AM +0100, Geert Uytterhoeven wrote:
> Note that the size of the entries in the pseudo palette used to depend on the
> mode, i.e. u16 for bpp = 16, u32 for bpp = 24 or 32.

They used to.  However, reading the code in 2.5 today, this appears to be
no longer the case - they're all one size (u32).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

