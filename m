Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTEGP7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTEGP7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:59:43 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:49457 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264094AbTEGP7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:59:40 -0400
Subject: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052323940.2360.7.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 07 May 2003 11:12:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with kernel version 2.5.69, I am
encountering what appears to be increased
interrupt latency or spikes in interrupt latency.

I noticed this on two serial drivers that use programmed
I/O with FIFOs. On 2.5.68, no problems. On 2.5.69
plenty of underruns. Inspecting the driver tracing, it
does not look like lost interrupts.

I see this on 2 different machines
(one SMP server and one laptop).

There were changes involving the return type of
interrupt handlers (from void to irqreturn_t) in 2.5.69.
Could this be related?

Has anyone else seen similar results?

If I can get time, I'll try and hook up a scope
to measure the latencies precisely. I want to
check to see if this is a known problems before doing so.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


