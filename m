Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUF3UkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUF3UkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUF3UkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:40:20 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:55508 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S262476AbUF3UkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:40:15 -0400
Date: Wed, 30 Jun 2004 15:38:21 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: NFS corruption in 2.4.x, not 2.6.7
Message-ID: <20040630203821.GA12223@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repeated copy and compare operations from linux to novell or tru64 systems
cause occasional corruption to the file copied.  This problem has occurred
in all the 2.4.x kernels I've tried 2.4.20-2.4.27-rc2 (I did not try all of
them, but several), however, I have yet to run into the problem on the
2.6.7 kernel.

I would like to stick with 2.4.x kernel, for now, since I would like to
continue using the qlogic drivers with failover.  The new device-mapper
multipath stuff (needed for failover now) in the 2.6+patches kernels, just
is not ready yet (I need to test it more).

Sniffing packets going between the linux and novell server with tcpdump in
the middle, the data going to the novell server appears correct. The data
that was corrupted was retransmitted, both packets look correct.

I noticed that the 2.4.x kernels send fragments backwards (i.e. offset 0, is
the last fragment sent) while the 2.6.7 kernel sends fragments with
increasing offsets.

Initially this seems like a novell problem, but the fact that 2.6.7 seems to
work and that the problem also occurs copying to tru64, points to a linux
2.4 series problem.  Any ideas on what changed between 2.4 and 2.6 that
could have fixed this?

Andy
