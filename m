Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbTIDVQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbTIDVQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:16:20 -0400
Received: from andrea.eurotel.sk ([194.154.230.74]:235 "EHLO andrea.eurotel.sk")
	by vger.kernel.org with ESMTP id S265550AbTIDVQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:16:19 -0400
Subject: problem with IRDA
From: Juraj <duro@gsm.eurotel.sk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: OM8ACE
Message-Id: <1062710272.4283.21.camel@nezabudka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 23:17:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a problem with IRDA on my linux system. I am using 2.4.22 kernel.
I use GSM phone to connect to internet over IR port. When I try to run
pppd, it fails, due to problem with IR communication. 

/var/log/messages says:
Sep  4 22:20:34 nezabudka pppd[3932]: pppd 2.4.1 started by root, uid 0
Sep  4 22:20:34 nezabudka kernel: IrCOMM protocol (Dag Brattli)
Sep  4 22:20:44 nezabudka kernel: irlap_adjust_qos_settings(), Detected buggy peer, adjust mtt to 10us!
Sep  4 22:20:46 nezabudka pppd[3932]: Connect script failed

I looked to linux source. In net/irda/qos.c I found the mtt parameter, but it is set to 10us.
	unsigned sysctl_min_tx_turn_time = 10;

Next I have found, that in 2.4.17 kernel was made some IrDA update by Jean Tourrilhes.
Some time ago I used 2.4.16 kernel, and all was working fine. Problems starts,
since I started using 2.4.18, and higher kernels.

Problem is not in pppd or kernel configuration, or some missing module, because communication sometimes 
go fine.  When I run irdadump utility in one or two terminals, and then I run pppd, it gets working properlly.
I thing there is something wrong with some timing.
Problem is also present, when I try to talk to phone with minicom.

Could someone help?

Thank you.

Juraj Buliscak.

