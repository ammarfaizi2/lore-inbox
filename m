Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTCEVl5>; Wed, 5 Mar 2003 16:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTCEVl5>; Wed, 5 Mar 2003 16:41:57 -0500
Received: from [12.36.124.2] ([12.36.124.2]:9095 "EHLO intranet.resilience.com")
	by vger.kernel.org with ESMTP id <S262780AbTCEVl4>;
	Wed, 5 Mar 2003 16:41:56 -0500
Mime-Version: 1.0
Message-Id: <p05210507ba8c20241329@[10.2.0.101]>
In-Reply-To: <20030305205032.GD2958@atrey.karlin.mff.cuni.cz>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.33.0303041434220.1438-100000@localhost.localdomain>
 <20030305205032.GD2958@atrey.karlin.mff.cuni.cz>
Date: Wed, 5 Mar 2003 13:52:16 -0800
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Linux vs Windows temperature anomaly
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been seeing a curious phenomenon on some PIII/ServerWorks 
CNB30-LE systems.

The systems fail at relatively low temperatures. While the failures 
are not specifically memory related (ECC errors are never a factor), 
we have a memory test that's pretty good at triggering them. Data is 
apparently getting corrupted on the front-side bus.

Here's the curious thing: when we run the same memory test on a 
Windows 2000 system (same hardware; we just swap the disk), we can 
run the ambient temperature up to 60C with no problem at all; the 
test will run for days. (It occurred to us to try Win2K because the 
hardware vendor was using it to test systems at temperature without 
seeing problems.)

Swap in the Linux disk, and at that temperature it'll barely run at 
all. The memory test fails quickly at 40C ambient.

FWIW, CPU cooling is pretty good in this box.

So, the puzzle: what might account for temperature sensitivity, of 
all things, under Linux 2.4.9-31 (RH 7.2), but not Win2K?
-- 
/Jonathan Lundell.
