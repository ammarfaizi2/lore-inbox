Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270759AbUJUSCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbUJUSCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270781AbUJUR6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:58:39 -0400
Received: from lum.tdiedrich.de ([193.24.211.71]:14037 "EHLO lum.tdiedrich.de")
	by vger.kernel.org with ESMTP id S270782AbUJURxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:53:47 -0400
Date: Thu, 21 Oct 2004 19:53:31 +0200
From: Tobias Diedrich <ranma@tdiedrich.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Timothy Miller <miller@techsource.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041021175331.GA21760@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Timothy Miller <miller@techsource.com>
References: <4176E08B.2050706@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <4176E08B.2050706@techsource.com>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://www.uguu.de/~ranma/gpg-key
User-Agent: Mutt/1.5.6+20040907i
X-Virus: No
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.7
X-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> (2) How much would you be willing to pay for it?

For a GFX card without 3D I'd say about $30, maybe double it for the
geekness/support the idea factor.

> (5) What's most important to you, performance, price, or stability?
> Please read the FAQ at  http://www.tux.org/lkml/

I'd like to see a graphics card with a really good YV12 to RGB Overlay
and/or a blitter that can do the conversion.  A lot of cards do
ok when scaling YUY2, but have problems with YV12 (This _might_ be a
driver problem).  Scaling is more difficult with YV12 because
the chroma resolution is half the luma resolution in both dimensions
and not just in the horizontal direction.

Also more than 8Bits per Channel could noticably improve video quality.
(AFAIK good Standalone DVD Players do 10bits per component, which is the
maximum the mpeg2 spec supports)

Many cards have 10bit DACs to improve precision when gamma correction is
used, but AFAIK you can't directly output video with that precision.

I also wondered wether it would be feasible to have a video capture card
directly capture into GFX memory, show the video being captured on the
overlay and do a dma transfer into cpu memory while reordering the data
as to improve cpu cacheline usage for DCT processing (Have the
macroblocks use contiguous memory chunks or let the card do
the DCT). :-)

And even if the card doesn't do 3D it might be useful to have some pixel
shader functionality, IIRC the ATI Windoze drivers can use the pixel
shaders to do deblock/dering video postprocessing on the card.

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
失敗する可能性のあるものは、失敗する。
np: RAID - 不誠実な道の上でのサバイバル

