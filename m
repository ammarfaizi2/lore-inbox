Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbRHBCiG>; Wed, 1 Aug 2001 22:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268343AbRHBCh4>; Wed, 1 Aug 2001 22:37:56 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:18823 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S268332AbRHBChp>;
	Wed, 1 Aug 2001 22:37:45 -0400
Message-ID: <3B68BED6.5754F8F2@randomlogic.com>
Date: Wed, 01 Aug 2001 19:45:42 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <Pine.LNX.4.33.0108021006550.1389-100000@mobile.torri.linux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Torri wrote:
> 
> Are the AMD CPUs really geared at the silicon level for true SMP? Some
> friend of mine says that just because you can pull the state pin by a
> chipset to remove the CPU and start another doesn't say the CPU is really
> made for SMP. It just says that they have made it work through the
> chipset. I am not sure if the Intel family are really true SMP or not.
> 
> I would apprecite some feedback on this.
> 

The Athlon Thunderbird as well as the Athlon MP (which uses the new Palamino [sp?]) core) both have true SMP support. All the Athlon's have a bus that is based
upon the Alpha EV6 bus, which supports multiple processors (greater than just 2) running and a bus speed up to 400MHz (too bad the systems themselves can't
support this kind of speed). The MP chips have a faster core and some additional logic that gives them a 10 - 20% boost in performance over a straight Athlon.
Part of this logic is a feature such that, in the case of a cache miss, the CPU will check the cache on the other CPU to see if it has the data it needs. If it
does, it loads from that CPU, avoiding a memory access.

In addition, the EV6 bus has a separate bus for each CPU, as compared to the Intel SMP bus architecture which shares the bus. An Intel SMP machine will share
the available host bus bandwidth between the two CPUs, where the Athlon has a separate bus for each one.

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
