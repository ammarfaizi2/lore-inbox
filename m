Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVJJTAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVJJTAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJJTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:00:43 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:7301 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751106AbVJJTAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:00:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5ROGOTkiyou9Qz6VJgdEx/cePI7m2kyB/IeycUOSqYt2W8x2H4EBMyk/lHZ55YQ/iRIfjtWhB+kLTbCyI/3Gr9QTpBYNhT1edVm37T9LtTss1G2c9M/3VU/3jwoXn4kFIEIwX7VTi2cFJKSg8GMjkyE9h+PqNpYG7ua0FkMEfQ=
Message-ID: <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
Date: Mon, 10 Oct 2005 21:00:42 +0200
From: Lars Roland <lroland@gmail.com>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Direct Rendering drivers for ATI X300 ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Gerhard Mack <gmack@innerfire.net> wrote:
> Hello,
>
> Can anyone tell me if there are working open source DRM drivers that work
> on recent 2.6.x kernels for the ATI X300?  I've tried dri.sourceforge.net
> and r300 but neither seems to even bother compiling.  I've spent several
> hours on google without luck.
>
>         Gerhard

What are your dmesg reporting, when loading the modules, if you see
something along these lines:

-------------------
[drm] Initialized drm 1.0.0 20040925
PCI: Unable to reserve mem region #1:8000000@c0000000 for device 0000:01:00.0
[drm] Initialized radeon 1.19.0 20050911 on minor 0:
[drm] Used old pci detect: framebuffer loaded
mtrr: 0xc0000000,0x8000000 overlaps existing 0xc0000000,0x4000000
[drm:radeon_do_init_cp] *ERROR* Cannot use PCI Express without GART in
FB memory
-------------------

then you may have hit a possible x300/pci express issue - other than
that I have it working perfectly here with kernel 2.6.14rc1, Quake3 is
playable (although I am experiencing some minor problems with MergedFB
combined with 3D gaming). I have written a small guide for Gentoo that
explains how to get DRI/DRM working with R300 (and newer cards) all
though you may not use Gentoo it should be very easy to get it working
on other distributions:

The guide is here:
http://forums.gentoo.org/viewtopic-t-374745-highlight-r300.html


--------------
Regards.

Lars Roland
