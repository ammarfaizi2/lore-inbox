Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTBUKgi>; Fri, 21 Feb 2003 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTBUKg2>; Fri, 21 Feb 2003 05:36:28 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:5706 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267350AbTBUKf4>; Fri, 21 Feb 2003 05:35:56 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.21.0302211007080.9232-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302211007080.9232-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045824362.1202.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 18:46:44 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 17:09, Geert Uytterhoeven wrote:
> On 21 Feb 2003, Antonino Daplas wrote:
> > Note: I cannot test with 12x22 fonts in 2.4 because some/most drivers do
> > not support it.
> 
> Which specific drivers are you talking about? All drivers for popular cards
> support fontwidth 12 (Matrox, ATI, nVidia, 3Dfx, Permedia, VESA, ...).
> 
>
You're absolutely correct, I'm wondering why I thought that :-)  Here's
a benchmark for 12x22, and it's 2x slower than 8x16, 2.4.x or 2.5.x. 
Still, the 2.5.x version is slower than 2.4.x.

Tony

no accel
scrollmode: yredraw
font: 12x22
visual: packed pixels

time cat /usr/src/linux/MAINTAINERS

linux 2.4.20

bpp8
----
real    0m4.984s
user    0m0.000s
sys     0m4.940s

bpp16
-----
real    0m9.188s
user    0m0.000s
sys     0m9.090s

bpp24
-----
real    0m14.574s
user    0m0.000s
sys     0m14.380s

bpp32
-----
real    0m18.578s
user    0m0.000s
sys     0m18.390s

linux-2.5.62

bpp8
----
real    0m5.247s
user    0m0.001s
sys     0m5.245s

bpp16
-----
real    0m9.640s
user    0m0.001s
sys     0m9.591s

bpp24
-----
real    0m15.943s
user    0m0.001s
sys     0m15.944s

bpp32
-----
real    0m19.653s
user    0m0.002s
sys     0m19.651s


