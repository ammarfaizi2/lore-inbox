Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276052AbRJPMpf>; Tue, 16 Oct 2001 08:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJPMpZ>; Tue, 16 Oct 2001 08:45:25 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:43004 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S276052AbRJPMpR>;
	Tue, 16 Oct 2001 08:45:17 -0400
Posted-Date: Tue, 16 Oct 2001 14:45:47 +0200
Date: Tue, 16 Oct 2001 14:45:47 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
Subject: sendto syscall is slow
In-Reply-To: <Pine.LNX.4.33.0110151105400.22170-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.10.10110161438140.13894-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm doing new qos discipline developement and use own
mesurment tool. It simply uses PF_PACKET and then
doing sendto/recv simulating various flows.
(I use both lo and eth0 where I short-connected RX-TX
 pins in single ethcard)

I can't get beyond 25 000 packets per second. gprof:
Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total           
 time   seconds   seconds    calls  ms/call  ms/call  name    
 35.67      5.39     5.39   498750     0.01     0.01  sendto
 26.67      9.42     4.03  1000826     0.00     0.00  poll
 19.06     12.30     2.88   498750     0.01     0.01  recv

Is there any faster way to force raw packets to kernel ? I need
to push qos discipline to its edge but I can't because send
syscall is bottleneck.
Is it possible to tx multiple packets in sinhle call or should
I extend kernel myself for this testing purpose ?

thanks, devik


