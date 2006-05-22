Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWEVPNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWEVPNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWEVPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:13:06 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:24237 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750924AbWEVPNE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:13:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Haar =?iso-8859-1?q?J=E1nos?= <djani22@netcenter.hu>
Subject: Re: swapper: page allocation failure.
Date: Tue, 23 May 2006 01:12:45 +1000
User-Agent: KMail/1.9.1
Cc: nickpiggin@yahoo.com.au, cw@f00f.org, linux-kernel@vger.kernel.org
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs>
In-Reply-To: <031001c67db1$a8c4a1e0$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605230112.45564.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 01:08, Haar János wrote:
> ----- Original Message -----
> From: "Con Kolivas" <kernel@kolivas.org>
> > Try with one of the alternative vmsplit options that gives you more
>
> lowmem?
>
> > That might break certain applications though.
>
>              total       used       free     shared    buffers     cached
> Mem:       4049724    4021196      28528          0      16384    3217288
> Low:       4049724    4021196      28528
> High:            0          0          0
> -/+ buffers/cache:     787524    3262200
> Swap:            0          0          0
>
> This is an 64 bit machine, the "concentrator".
>
> It looks like use all, the 4G ram as "lowmem".
> If i replace the cpu on my nodes to 64bit capable ones, i can use all the
> memory as buffer-cache? :-)

Heh yes indeed. It's only if you're stuck on 32bit for whatever reason that 
you'd need a different vmsplit. There is no need for highmem when 64bit 
allows bazillions of bytes of lowmem :)

-- 
-ck
