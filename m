Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbRFAEL4>; Fri, 1 Jun 2001 00:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263358AbRFAELq>; Fri, 1 Jun 2001 00:11:46 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4359 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263357AbRFAELi>; Fri, 1 Jun 2001 00:11:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PID of init != 1 when initrd with pivot_root
Date: 31 May 2001 21:11:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9f74l2$1i4$1@cesium.transmeta.com>
In-Reply-To: <20010601040627.A1335@ivan.doma>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010601040627.A1335@ivan.doma>
By author:    Ivan <pivo@pobox.sk>
In newsgroup: linux.dev.kernel
>
> Well, I upgraded and found pivot_root and the problem is that how do I make init
> run with PID 1. My linuxrc gets PID 7.
> 
>     1 ?        00:03:05 swapper
>     2 ?        00:00:00 keventd
>     3 ?        00:00:00 kswapd
>     4 ?        00:00:00 kreclaimd
>     5 ?        00:00:00 bdflush
>     6 ?        00:00:00 kupdated
>     7 ?        00:00:00 linuxrc
> 
> init doesn't like running with any other PID than 1. I could probably revert to
> the not so old way of doing things and exit linuxrc and let the kernel change
> root. But then I wouldn't be able to mount root over samba :-(. ( not that I
> have any samba shares :-)
> 

This is this way for backwards bug compatibility.  Use the following
command line options to make it behave properly:

	ram=/dev/ram0 init=/linuxrc

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
