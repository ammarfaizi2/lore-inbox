Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbTCVGYS>; Sat, 22 Mar 2003 01:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262044AbTCVGYS>; Sat, 22 Mar 2003 01:24:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:49415 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S262042AbTCVGYR>;
	Sat, 22 Mar 2003 01:24:17 -0500
Date: Sat, 22 Mar 2003 07:30:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance with pcnet32 on SMP
Message-ID: <20030322063038.GB26167@alpha.home.local>
References: <Pine.LNX.4.53.0303202346220.3340@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303202346220.3340@skynet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
> I have being noticing some seriously poor network performance with SMP
> enabled. The machine is a xSeries 350 with quad xeon procesors. Under UP,
> I get decent transfer rates but with SMP enabled, it won't get over 2kB/s.
> I tried binding interrupts to one processor with

I've already had problems with pcnet32 (but they were 79c971). Basically,
connected to a 100 full-duplex, they would suddenly switch back to half
duplex under heavy load, and then I got very very low speeds of course.

Since yours works in UP, this may not be related to the same problem, but who
knows ?  I see in your dmesg that the card is connected to a 10 half link. Have
you tried a 100 Mbps just in case ?

Regards,
Willy

