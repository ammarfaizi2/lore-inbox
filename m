Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288999AbSA0WxU>; Sun, 27 Jan 2002 17:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288993AbSA0WxK>; Sun, 27 Jan 2002 17:53:10 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:34538 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288992AbSA0Www>;
	Sun, 27 Jan 2002 17:52:52 -0500
Message-Id: <m16Uy9p-000OVeC@amadeus.home.nl>
Date: Sun, 27 Jan 2002 22:52:17 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: PROBLEM: high system usage / poor SMP network performance
cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16UyCO-0002zE-00@the-village.bc.nu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16UyCO-0002zE-00@the-village.bc.nu> you wrote:
>>     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
>>     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle

> The important bit here is     ^^^^^^^^ that one. Something is causing 
> horrendous lock contention it appears. Is the e100 driver optimised for SMP 
> yet ?

there's WAY too many busy waits (upto 500 msec with irq's disabled) in e100
to call it smp optimized.... also in most tests I've seen eepro100 won
outright
