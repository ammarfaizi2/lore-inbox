Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947399AbWKLByX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947399AbWKLByX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 20:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947400AbWKLByX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 20:54:23 -0500
Received: from soloth.lewis.org ([69.28.69.2]:49318 "EHLO soloth.lewis.org")
	by vger.kernel.org with ESMTP id S1947399AbWKLByX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 20:54:23 -0500
Date: Sat, 11 Nov 2006 20:54:19 -0500 (EST)
From: Jon Lewis <jlewis@lewis.org>
To: linux-kernel@vger.kernel.org
Subject: spin_trylock/spin_unlock panic in 2.6.9-42.0.3.EL
Message-ID: <Pine.LNX.4.61.0611112029100.2498@soloth.lewis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-milter-ns-Report: lewis.org; NS 13706 ns1.atlantic.net. [209.208.0.7]; NS 13706 ns2.atlantic.net. [209.208.42.140]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system running CentOS 4.4 (kernel 2.6.9-42.0.3.EL) which crashed 
several times in just over an hour a couple nights ago.  Each time, the 
last messages / only indication of trouble was:

net/ipv4/icmp.c:239: spin_trylock(net/core/sock.c:f7c27a60) already locked
by net/ipv4/icmp.c/239
kernel panic - not syncing:
net/ipv4/icmp.c:251:spin_unlock(net/core/sock.c:f7c27a60) not locked

In irc, someone suggested this might be caused by bad hardware, but I have 
time believing that hardware going bad could cause the kernel to lose 
track of spinlocks, especially in exactly the same way repeatedly.

The system is an old Tyan Tiger 200, single PIII-933, 1GB RAM, acting as 
both a mail/web server and a NAT router using the two built in Intel 
825579 FE interfaces.

This system has been in use and stable for several months prior to these 
crashes.

----------------------------------------------------------------------
  Jon Lewis                   |  I route
  Senior Network Engineer     |  therefore you are
  Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
