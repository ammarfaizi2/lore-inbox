Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJYTad>; Fri, 25 Oct 2002 15:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSJYTad>; Fri, 25 Oct 2002 15:30:33 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:38154 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S261559AbSJYTac>; Fri, 25 Oct 2002 15:30:32 -0400
Message-ID: <3DB99E3D.798B9A5F@compro.net>
Date: Fri, 25 Oct 2002 15:40:45 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT]AMD/Intel interrupt latency (jitter) differences?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We have a proprietary application that is an emulation of an old real-time os
(MPX-32). We have a couple of pieces of hardware (pci cards) with soon to be GPL
drivers that go along with the emulation package and the hardware. We are using
a 2.4.18 kernel with the O(1) scheduler and a couple of other patches. One of
these pieces of hardware is a pci card with 6 each 1us resolution timers and 8
external interrupts (4 in and 4 out). We have fortran a program on the old
real-time os that tells us about the interrupt latency and determinism (jitter).
When we run this program in the emulation on an intel box all is well. When we
run this in the emulation on an AMD MP 1900+ box the determinism (jitter) is
very bad. Sometimes as much as 500us. On the Dual Intel 2.2 p4 zeon the
determinism (jitter) is under 50us. All the other benchmarks we run under the
emulation tell us that the AMD box is the faster box. It's also cheaper. So I
guess my question is, are there any known problem with AMD's and interrupt
latency jitter. I might also add that the only way we get satisfactory numbers,
even on the P4 zeons, was with the affinity calls in the O(1) scheduler along
with the affinitization of the pci cards' irq. We basically create a pset for
our app using these affinity calls then do the same with the irqs down in the
driver for this pci card. So our emulation is run in one processor and all else
(linux) in the other. We do the same for all the irqs. Why does this only give
good results on intel and not amd??? We have tested many intel MB/P4 combos but
only one AMD, a Tyan s2466n.

Sorry if I'm wasting your time
Thanks and regards

Mark
