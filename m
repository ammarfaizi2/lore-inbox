Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTEGT3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEGT3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:29:31 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:54080 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264253AbTEGT2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:28:40 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1052323940.2360.7.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1052336482.2020.8.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 May 2003 14:41:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 11:12, Paul Fulghum wrote:
> Starting with kernel version 2.5.69, I am
> encountering what appears to be increased
> interrupt latency or spikes in interrupt latency.
> ...
> I see this on 2 different machines
> (one SMP server and one laptop).
> ...
> If I can get time, I'll try and hook up a scope
> to measure the latencies precisely. I want to
> check to see if this is a known problems before doing so.

Here are some results with a scope hooked to
the hardware while running tests with a regular
interrupt pattern:

2.4.20-8 (redhat)
Latency 20-30usec
Spikes to 80usec

2.5.68
Latency 20-30usec
Spikes to 100usec

2.5.69
Latency 100-110usec (5x increase)
Spikes from 5-10 milliseconds

This is all on a PCI adapter not sharing interrupts
on a dual Pentium II-400 Netserver LC3.

Any ideas what happened?

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


