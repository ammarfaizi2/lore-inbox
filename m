Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbRHBIkf>; Thu, 2 Aug 2001 04:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268854AbRHBIkZ>; Thu, 2 Aug 2001 04:40:25 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:43787 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S266718AbRHBIkL>;
	Thu, 2 Aug 2001 04:40:11 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: changes to kiobuf support in 2.4.(?)4
Date: 2 Aug 2001 08:23:37 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9mi3g9.36p.kraxel@bytesex.org>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 996740617 3337 127.0.0.1 (2 Aug 2001 08:23:37 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The reason of the large allocation and to put the bh inside the kiobuf
>  is that if we do a small allocation then we end with a zillion of
>  allocations of the bh and freeing of the bh at every I/O!! (not even at
>  every read/write syscall, much more frequently)

That is true for block device I/O only.  Current bttv versions are using
kiobufs to lock down user pages for DMA.  But I don't need the bh's to
transfer the video frames ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
