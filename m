Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbRGKQ4b>; Wed, 11 Jul 2001 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbRGKQ4V>; Wed, 11 Jul 2001 12:56:21 -0400
Received: from geos.coastside.net ([207.213.212.4]:31723 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267355AbRGKQ4I>; Wed, 11 Jul 2001 12:56:08 -0400
Mime-Version: 1.0
Message-Id: <p05100361b77232f67994@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.30.0107111625410.1811-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0107111625410.1811-100000@Appserv.suse.de>
Date: Wed, 11 Jul 2001 09:47:48 -0700
To: Dave Jones <davej@suse.de>, Hugh Dickins <hugh@veritas.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's 
 x86info
Cc: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:28 PM +0200 2001-07-11, Dave Jones wrote:
>On Wed, 11 Jul 2001, Hugh Dickins wrote:
>
>>  Am I paranoid?
>
>Probably :)
>The Intel CPUs with PSN I've seen simply drop 1 level.
>What other CPUs support this feature? ISTR Transmeta had it?
>Do they behave the same?
>
>>   I feel nervous about "c->cpuid_level--" inferring
>>  what we expect to happen to it, would prefer to check it (below).
>>  +		c->cpuid_level = cpuid_eax(0);
>
>No biggie, either solution is fine with me.

HD's version has the advantage of not having to make assumptions 
about how future CPUs might handle the level, and leaves open the 
alternative possibility of leaving the level at 3 (or some future 4) 
and just turning off the serial-number capability.
-- 
/Jonathan Lundell.
