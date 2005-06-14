Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFNMy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFNMy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFNMy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:54:28 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:27793 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261216AbVFNMyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:54:22 -0400
Date: Tue, 14 Jun 2005 14:54:18 +0200
From: Christian Leber <christian@leber.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lzma support: decompression lib, initrd support
Message-ID: <20050614125418.GA12944@core.home>
References: <20050607213204.GA2645@core.home> <20050607145903.4b2ac9bf.akpm@osdl.org> <42AECFF3.7030604@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AECFF3.7030604@grupopie.com>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 01:39:15PM +0100, Paulo Marques wrote:
> >[...]
> >>+	for (pb = 0; prop0 >= (9 * 5); pb++, prop0 -= (9 * 5));
> >>+	for (lp = 0; prop0 >= 9; lp++, prop0 -= 9);
> >
> >Put the ";" on a line of its own.
> >
> >I'd have thought the above could be done arithmetically?
> 
> I just tried a small test program to see the speed/code size difference 
> to this code, which is the arithmetic equivalent:
> 
>   pb = prop0 / (9 * 5);
>   prop0 %= (9 * 5);
>   lp = prop0 / 9;
>   prop0 %= 9;
> 
> This code runs a lot faster than the original. This is not very 
> important since it runs only once AFAICT.

Was allready fixed in the newer version.
But i doubt that this _few_ cycles matter in any way.

The odd thing is, that the orginal lzma author has both version in the
lastest version of his sdk, but commented out the arithmetic version ?!?

> As for the code size, it is smaller if compiled with -Os, but larger 
> when compiled with -O2 or -O3.

-O3 helps a lot for the actual decompression


Christian Leber

-- 
http://www.nosoftwarepatents.com

