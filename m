Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268555AbTANDiE>; Mon, 13 Jan 2003 22:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTANDiE>; Mon, 13 Jan 2003 22:38:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:7653 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268560AbTANDhp> convert rfc822-to-8bit;
	Mon, 13 Jan 2003 22:37:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net, alan@lxorguk.ukuu.org.uk
Subject: Re: IDE DMA disabled with via82cxxx on kernels >= 2.5.35
Date: Mon, 13 Jan 2003 19:47:08 -0800
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030114024949.GA165@rushmore>
In-Reply-To: <20030114024949.GA165@rushmore>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131947.08610.akpm@digeo.com>
X-OriginalArrivalTime: 14 Jan 2003 03:46:29.0554 (UTC) FILETIME=[858B6120:01C2BB7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon January 13 2003 18:49, rwhron@earthlink.net wrote:
>
> 2.4.20-pre3-jam1:
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
>  Timing buffered disk reads:  64 MB in  2.07 seconds = 30.92 MB/sec
> 
> 2.5.53-mm1
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  7.20 seconds = 17.78 MB/sec
>  Timing buffered disk reads:  64 MB in 19.66 seconds =  3.26 MB/sec

2.5.53-mm1 had a dud patch in it which made part of the kernel think HZ=100,
other parts think HZ=1000, depending on whether the .c file happened to
include config.h before including param.h.

Hence your nice 10x discrepancy.



