Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSKKVKC>; Mon, 11 Nov 2002 16:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKKVKC>; Mon, 11 Nov 2002 16:10:02 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:1295 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S261330AbSKKVKA>; Mon, 11 Nov 2002 16:10:00 -0500
Message-ID: <YWxhbg==.563e560fc9743df6e2cd56ac2568e2c0@1037049066.cotse.net>
Date: Mon, 11 Nov 2002 16:11:06 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
From: "Alan Willis" <alan@cotse.net>
To: <akpm@digeo.com>
In-Reply-To: <3DD01B32.4A113A71@digeo.com>
References: <3DCC2ABE.5DDE9882@digeo.com>
        <YWxhbg==.a11f3fbc6d68c50c7f190513c1d3bacf@1037045821.cotse.net>
        <3DD01B32.4A113A71@digeo.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <alan@cotse.com>, <linux-kernel@vger.kernel.org>, <vs@namesys.com>
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's an awful lot of mapped memory.  Have you been altering
> /proc/sys/vm/swappiness?  Has some application run berzerk
> and used tons of memory?
>
> Slab:             7592 kB
> Committed_AS:   423120 kB
> PageTables:       1996 kB
> ReverseMaps:     69425
> HugePages_Total:    15
> HugePages_Free:     15
> Hugepagesize:     4096 kB

vm.swappiness was set to 0

>
> You've lost 60 megabytes in hugepages!  Bill's patch (which is in .47)
> changes the initial number of hugetlb pages to zero, which is rather
> kinder.
>
> So I don't _think_ there's a leak here.  It could be that your
> normal workload fits OK ito 256 megs, but thrashes when it is
> squeezed into 196 megs.
>
> Suggest you do `echo 0 > /proc/sys/vm/nr_hugepages' and retest.

Done, vm.nr_hugepages = 0 # from 15

I'll stick to 2.5.46 for a while yet I guess, to be sure.

-alan



