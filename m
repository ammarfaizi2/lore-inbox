Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319215AbSHUVEv>; Wed, 21 Aug 2002 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSHUVEv>; Wed, 21 Aug 2002 17:04:51 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:44560 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S319215AbSHUVEv>; Wed, 21 Aug 2002 17:04:51 -0400
Date: Wed, 21 Aug 2002 14:06:28 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Nagy Tibor <nagyt@otpbank.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem determining number of CPUs
In-Reply-To: <3D63A180.C663294E@otpbank.hu>
Message-ID: <Pine.LNX.4.44.0208211402390.6621-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Nagy Tibor wrote:

> Hi,
> 
> Linux kernel versions 2.4.18, 2.4.19, 2.4.20pre4 do not determine
> correctly the number of CPUs on our system. We see 8 CPUs instead of 4,
> however the system works.
>
> Our machine: Dell PowerEdge 6600, 4 Xeon 1400 Mhz, 4GB RAM

Perfectly normal on that machine; newer Xeon CPUs have a feature called 
hyperthreading, which makes each physical CPU show up as two. If you have 
many threads running, or a bunch of processes, you should see a 
performance increase. but keep in mind that for each physical CPU you 
still only have one CPU core, so you can't expect to run 8 tasks at full 
speed. Hyperthreading uses idle cycles on one task to perform active 
cycles on another task, in its most basic sense. I'm not going to delve 
into great detail here as it's off-scope for this list, but if you read 
the datasheets and product specification for the Intel Xeon processor 
(available at Intel's developer site) you can learn more about this nifty 
feature of these processors.

Hope this cleared up some questions you may have had.
-Kelsey

