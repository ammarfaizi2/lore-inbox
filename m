Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSGJT4g>; Wed, 10 Jul 2002 15:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSGJT4f>; Wed, 10 Jul 2002 15:56:35 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:25078 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S317591AbSGJT4f>; Wed, 10 Jul 2002 15:56:35 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Linux <linux-kernel@vger.kernel.org>
Subject: HZ, preferably as small as possible
Date: Wed, 10 Jul 2002 12:59:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to see HZ closer to 100 than 1000, for CPU power reasons. Processor
power states like C3 may take 100 microseconds+ to enter/leave - time when
both the CPU isn't doing any work, but still drawing power as if it was. We
pop out of C3 whenever there is an interrupt, so reducing timer interrupts
is good from a power standpoint by amortizing the transition penalty over a
longer period of power savings.

But on the other hand, increasing HZ has perf/latency benefits, yes? Have
these been quantified? I'd either like to see a HZ that has balanced
power/performance, or could we perhaps detect we are on a system that cares
about power (aka a laptop) and tweak its value at runtime?

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

