Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTAQUFw>; Fri, 17 Jan 2003 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267661AbTAQUFw>; Fri, 17 Jan 2003 15:05:52 -0500
Received: from stingr.net ([212.193.32.15]:11277 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S267658AbTAQUFu>;
	Fri, 17 Jan 2003 15:05:50 -0500
Date: Fri, 17 Jan 2003 23:14:45 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: cs89x0 in 2.5 (was Re: eepro100 - 802.1q - mtu size)
Message-ID: <20030117201445.GS12676@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org> <20030117172719.GA31343@codemonkey.org.uk> <20030117174928.GA8304@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030117174928.GA8304@gtf.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Jeff Garzik:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/split-dj1/net-cs89x0-media-corrections.diff
> 
> 
> IIRC it came from -ac tree without explanation, and I think akpm said it
> broke stuff.  Since it has an alive maintainer (akpm), I would rather
> let Alan and Andrew fight it out :)  Whatever they decide is fine with
> me for 2.5.

It is not a magic number in net drivers. I was author of this bit, and
without it I cannot start onboard nic on IBM PC300 GL (a lot of them I
have here). Actually, to _understand_ what this bit do you just need
to look at the driver source and see _how_ it works with
A_CNF_MEDIA_10B_2 constants. More specific, it expects that there are
single bits, and before my patch A_CNF_MEDIA_10B_2 was 0x60. 0x60 is
not a single bit.

I've thought this change is obvious, and as far as I can remember
Andrew has nothing against it.

-- 
Paul P 'Stingray' Komkoff Jr /// (icq)23200764 /// (http)stingr.net
 This message represents the official view of the voices in my head
