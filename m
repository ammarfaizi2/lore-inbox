Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292840AbSBVLKW>; Fri, 22 Feb 2002 06:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292843AbSBVLKM>; Fri, 22 Feb 2002 06:10:12 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:40204 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292840AbSBVLKE>; Fri, 22 Feb 2002 06:10:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Date: 22 Feb 2002 10:07:29 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna7c631.icv.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1014372449 18848 127.0.0.1 (22 Feb 2002 10:07:29 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  1.  Kill the ide-probe-mod by merging it with ide-mod. There is *really*
>       no reaons for having this stuff split up into two different
>      modules unless you wan't to create artificial module dependancies 
>  and waste space
>      of page boundaries during memmory allocation for the modules

Ah, seems you are the one who broke modular ide in 2.5.5:

Older kernels:
  insmod ide-mod, insmod ide-disk, insmod ide-probe-mod  => works.

2.5.5:
  insmod ide-mod, insmod ide-disk  => mounting /dev/hda2 doesn't work.

  Gerd

