Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUC2Cic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 21:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUC2Cic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 21:38:32 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:43716 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262517AbUC2Cib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 21:38:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16487.35872.160526.477780@gargle.gargle.HOWL>
Date: Sun, 28 Mar 2004 21:38:24 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I've run into a strange situation here.  I was having *terrible*
performance while doing a complile of the 2.6.5-rc2-mm2 kernel on my
system (Debian completely bleeding edge, plus udev and hotplug) along
with dealing with a USB problem where if I removed my Cuzer USB
device, it would never get de-allocated properly and the system load
would start to hang.

I've got 768mb of RAM, and 1gb of SWAP on the system, and I was using
about 110mb of swap, and around 360mb of cache, with around 20-30mb of
cache.  So using vmstat 1, I could see that the system was swapping in
just all the time, and the compile was just dog slow.  So I figured I
could get rid of some useless cache if I could just turn off swap.

No go.  Every time I tried, it would drop the swap down a bit (say
5-20mb), but then go OOM on me and die.  I thought this was completely
bogus.  If I've got the physical RAM available, and more cache and/or
buffer than is currently swapped to disk, why can't I kill swap?

John
