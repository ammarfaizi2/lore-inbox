Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUIAL5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUIAL5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUIALyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:54:03 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:31731 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S266204AbUIALvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:51:31 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 13:48:19 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409010920.13307.ornati@fastwebnet.it> <200409011821.06520.adaplas@hotpop.com>
In-Reply-To: <200409011821.06520.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DcbNBGEQ/QkIJol"
Message-Id: <200409011348.19645.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DcbNBGEQ/QkIJol
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 01 September 2004 12:21, Antonino A. Daplas wrote:
> On Wednesday 01 September 2004 15:20, Paolo Ornati wrote:
> > Ok, with this patch and CONFIG_FB_3DFX_ACCEL=y the scrolling speed
> > comes back (only a bit slower than with 2.6.8.1 without
> > CONFIG_FB_3DFX_ACCEL):
> >
> > $ time cat MAINTAINERS: ~2.67s
>
> Ok.  However, I'm still wondering at the scrolling speed, it's a bit
> slower than what I would expect (I get < 1 second with vesafb which is
> completely unaccelerated).
>
> Did you set info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN?
yes

> Do you use the 'nopan' boot option?
no

>
> Because if you answer yes to the first question and no to the second,
> that means that tdfxfb_pan_display() is probably broken.
>
> BTW, what does fbset -i say, and what's your hardware setup?

ASUS A7V (VIA Apollo KT133 Chipset)
AMD Duron 750
3dfx Voodoo Banshee 16 MB

lspci -v (attached)

$ fbset -i:	(from 2.6.9-rc1 + your new patch without CONFIG_FB_3DFX_ACCEL: 
see the next e-mail)

mode "800x600-85"
    # D: 60.753 MHz, H: 55.839 kHz, V: 84.992 Hz
    geometry 800 600 800 20971 8
    timings 16460 160 64 36 16 64 5
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : 3Dfx Banshee
    Address     : 0xe4000000
    Size        : 16777216
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 0
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 800
    MMIO Address: 0xe0000000
    MMIO Size   : 33554432
    Accelerator : Unknown (31)


>
> > Another interesting thing is that if I enable CONFIG_FB_3DFX_ACCEL
> > without your patch the screen becomes black and the kernel stop working
> > at boot time (when the mode switch happens).
>
> tdfxfb_cursor() is broken, so I disabled that.  It's the reason your
> machine hangs at boot time if CONFIG_FB_3DFX_ACCEL is set to y.

ok

>
> Tony

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.9-rc1)

--Boundary-00=_DcbNBGEQ/QkIJol
Content-Type: application/x-gzip;
  name="lspci.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci.gz"

H4sICBq2NUECA2xzcGNpAN1XUW/iOBB+hl8xj62uFCcBmqLtSsC2u6jlli0texLiwUkcsDaxI8fp
lv31Nw4BSha6pa3u4ZCwbGW+ycz3jT0OIW1CTgl8kakGT/Fgxtow7nfgjvlzISM54yw9gb7wT2F8
5zotp45DEybXd5bj1K8HOE7hSLEHIPZxtTLKvHSRaha3oZNmOPkBPRknmWaq8NI5G8OAcuFJqoJq
5Sqis7QNXpZCTNPcLGYBz2II2EPKohOIqGbCX4BbrQxYLNUCqAbWIvkPjhy75nF9AoliIdP+nHoR
O4ZJyn+xC8ceTKuVHk2oxyOuMZU2fKAPlEfGCqSIFqAlKCn1x2qVIBcWcjHs9V9LBXQ+D5GORMlZ
jYeA8U3+liqmEWbjy4BNj3dm3GoN5r/2Jk6qlW6GiETxmKrFBSEnkKI7EeQrC1eZJ1XABQKWa+bX
CvQFovv1r+CxORfBOi/DXYD/Wj4Jw3BNbsmQLXkmNeYYM2M4fMI0xrwT5YQFqhkWqENUaKAK/VHn
BSrYvZbbgkknkVEkYZQlTMFIZnpeFKX9XkWJY5JwMXtGpSJ0C/qfLoELhIXU/0P0TbfVqXfrq0zq
q4XziNPectqEYX/YA6wBjNFEk78gT88ix5tqcylMCoMR84cwVHy4p+D25ODYy2JJpNKp2Waea0o4
30tWa3qoiDbcj7pItdAK5WHqGSpaNrFhYsxt1N5fQ6Y78jQh3X/p9afb0u7xffRdSTFDyo5L0RxG
DHq7/QbNMj+NNT+OfTA/zv+fH/IWfhrQfdUB0OkN+wUxDnnD/i8laxI8PyyHcxTrUs+ZEkw/Ua0N
t4xGJo4Ri7k5yTNfS4VRnZ7AjQ5O4fbupuZaznndDL3l+Nda662U/uzKoN9DzfNNtdtNcxxs+nEQ
uqV+LKSo7erJS+QhJHpI4iCLNDfhUqBZwOUWmVcYIMsf5nLCPz/pA4NvIwcD6sDkauASq6gHr9QP
StA23IsfQv4UhhPuM7Ac61XUWaTM3WYnWLZ7MAPYVAQW7CqsQ7OHGY1ZHsx/xkMpf/f1ncQyl7JV
PPjeFJuxVHS2TcNQyZinbHNMLIq9jScn3tJ2XlH3Yu4jrahFyLtI7262jRF++9mmLBrlZ2fuftxZ
4xncxmerUdql5IW7FGv0GqGXjwkVKZcCbr8OjIcPmUAB+Eyw4CNMAp4aUDBdv+76EGmt5bfH+HMH
lYwTqrmxeiqq8yl8REWQdupr/sBW576UgZTQxdjmjBXaOqUWiG5LHbCnGDVe4IZ6KfqGbrS8Lq0c
jS/XghdX8hANthqAZW19hpCXErr8FHmCbLz8A2ZL3cAtHcK/aYSX71znt+rzL5eVw9wcDgAA

--Boundary-00=_DcbNBGEQ/QkIJol--
