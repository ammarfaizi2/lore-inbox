Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKVWxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKVWxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbUKVWwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:52:13 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:26143 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261194AbUKVWvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:51:16 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <5.1.0.14.2.20041123094109.04003720@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 23 Nov 2004 09:50:36 +1100
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning 
  and sickness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41A21C82.3060105@devicelogics.com>
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
 <419E6B44.8050505@devicelogics.com>
 <419E6B44.8050505@devicelogics.com>
 <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

At 04:06 AM 23/11/2004, Jeff V. Merkey wrote:
>I've studied these types of problems for years, and I think it's possible 
>even for Linux.

so you have the source code --if its such a big deal for you, how about you 
contribute the work to make this possible ?

the fact is, large-packet-per-second generation fits into two categories:
  (a) script kiddies / haxors who are interested in building DoS tools
  (b) folks that spend too much time benchmarking.

for the (b) case, typically the PPS-generation is only part of it.  getting 
meaningful statistics on reordering (if any) as well as accurate latency 
and ideally real-world traffic flows is important.  there are specialized 
tools out there to do this: Spirent, Ixia, Agilent et al make them.

>[..]
>I see no other way for OS to sustain high packet loading about 500,000 
>packets per second on Linux
>or even come close to dealing with small packets or full 10 gigabite 
>ethernet without such a model.

10GbE NICs are an entirely different beast from 1GbE.
as you pointed out, with real-world packet sizes today, one can sustain 
wire-rate 1GbE today (same holds true for 2Gbps Fibre Channel also).

i wouldn't call pushing minimum-packet-size @ 1GbE (which is 46 payload, 72 
bytes on the wire btw) "real world".  and its 1.488M packets/second.

>The bus speeds are actually fine for dealing with this on current hardware.

its fine when you have meaningful interrupt coalescing going on & large 
packets to DMA.
it fails when you have inefficient DMA (small) with the overhead of setting 
up & tearing down the DMA and associated arbitration overhead.



cheers,

lincoln.

