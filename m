Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbSJ1NXX>; Mon, 28 Oct 2002 08:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbSJ1NXX>; Mon, 28 Oct 2002 08:23:23 -0500
Received: from p043.as-l031.contactel.cz ([212.65.234.235]:10880 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S262523AbSJ1NXW>;
	Mon, 28 Oct 2002 08:23:22 -0500
Date: Mon, 28 Oct 2002 14:27:52 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021028132752.GB1253@ppc.vc.cvut.cz>
References: <20021027010538.GA1690@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027010538.GA1690@babylon.d2dc.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 09:05:38PM -0400, Zephaniah E. Hull wrote:
> To make a long story short, mousedev.c does not properly implement the
> EXPS/2 protocol, specificly dealing with the wheel.
> 
> The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
> indicate movement of the first wheel, and 0x2 or 0xe for the second
> wheel.

Hi,
  I was talking about this problem with Vojtech some months ago,
and unfortunately we were not able to find correct way to implement it:
there are mouses (probably majority) which have only one wheel, and
which reports fast wheel movement as 2,3,4... or 0xe,0xd,.... Protocol
is documented this way on Microsoft web pages.

  Then there is another group of mices (mine A4Tech with two wheels
being one of them) which reports vertical wheel always as 1/0xF, and
horizontal as 2/0xE (and if you move both, they reports once horizontal
and once vertical wheel).

  Unfortunately we were not able to find how to detect these mouses in
advance, and when I asked A4Tech, I got back answer that I should use
their mouse driver, and not one delivered by Microsoft (although Linux
was every third word in question). From this answer I conclude that
there is no way to autodetect it, and it has to be specified by some
options passed to mouse driver.

					Petr Vandrovec
					vandrove@vc.cvut.cz

