Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbUKWB2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUKWB2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbUKWBZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:25:42 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:62101 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261212AbUKWBYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:24:00 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <5.1.0.14.2.20041123121526.034b7118@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 23 Nov 2004 12:23:24 +1100
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning  
  and sickness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41A2862A.2000602@devicelogics.com>
References: <5.1.0.14.2.20041123094109.04003720@171.71.163.14>
 <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
 <419E6B44.8050505@devicelogics.com>
 <419E6B44.8050505@devicelogics.com>
 <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
 <5.1.0.14.2.20041123094109.04003720@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:36 AM 23/11/2004, Jeff V. Merkey wrote:
>>>I've studied these types of problems for years, and I think it's 
>>>possible even for Linux.
>>
>>so you have the source code --if its such a big deal for you, how about 
>>you contribute the work to make this possible ?
>
>Bryan Sparks says no to open sourcing this code in Linux. Sorry -- I 
>asked. I am allowed to open source any modifications
>to public kernel sources like dev.c since we have an obligation to do so. 
>I will provide source code enhancements for the kernel
>for anyone who purchases our Linux based appliances and asks for the 
>source code (so says Bryan Sparks). You can issue a purchase
>request to Bryan Sparks (bryan@devicelogics.com) if you want any source 
>code changes for the Linux kernel.

LOL.  in wonderland again?

>>the fact is, large-packet-per-second generation fits into two categories:
>>(a) script kiddies / haxors who are interested in building DoS tools
>>(b) folks that spend too much time benchmarking.
>>
>>for the (b) case, typically the PPS-generation is only part of it. 
>>getting meaningful statistics on reordering (if any) as well as accurate 
>>latency and ideally real-world traffic flows is important. there are 
>>specialized tools out there to do this: Spirent, Ixia, Agilent et al make them.
>
>There are about four pages of listings of open source tools and scripts 
>that do this -- we support all of them.

so you're creating a packet-generation tool?
you mentioned already that you had to increase receive-buffers up to some 
large number.  doesn't sound like a very useful packet-generation tool if 
you're internally having to buffer >60K packets . . .
LOL.

>>i wouldn't call pushing minimum-packet-size @ 1GbE (which is 46 payload, 
>>72 bytes on the wire btw) "real world". and its 1.488M packets/second.
>I agree. I have also noticed that CISCO routers are not even able to 
>withstand these rates with 64 byte packets without dropping them,
>so I agree this is not real world. It is useful testing howevr, to 
>determine the limits and bottlenecks of where things break.

Cisco software-based routers?  sure ...
however, if you had an application which required wire-rate minimum-sized 
frames, then a software-based router wouldn't really be your platform of 
choice.

hint: go look at EANTC's testing of GbE and 10GbE L3 switches.

there's public test data of 10GbE with 10,000-line ACLs for both IPv4 & 
IPv6-based L3 switching.



cheers,

lincoln.

