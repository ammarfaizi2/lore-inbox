Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUHGAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUHGAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 20:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUHGAI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 20:08:27 -0400
Received: from nef.ens.fr ([129.199.96.32]:58898 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S268255AbUHGAIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 20:08:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
In-Reply-To: <1091744073.2597.15.camel@laptop.cunninghams>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams> <20040805181925.GB30543@kroah.com> <1091744073.2597.15.camel@laptop.cunninghams>
Date: Sat, 7 Aug 2004 02:08:24 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20040807000824.C657C18122@quatramaran.ens.fr>
From: ebrunet@quatramaran.ens.fr ( =?ISO-8859-1?Q?=C9ric?= Brunet)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Sat, 07 Aug 2004 02:08:24 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dans ens.mailing-lists.linux-kernel, vous avez écrit :
>> > - support for telling what class of device a driver is handling (I'm
>> > particularly interested in keeping the keyboard, screen and storage
>> > devices alive while suspending).
>> 
>> You can see that info today from userspace by looking in
>> /sys/class/input, /sys/class/graphics, and /sys/block

It is a minor point, but as many people are working on swsuspend right
now, I thought I'd mentionned it. It seems (as of 2.6.8.rc1) that the
screen is not shut down or put in a low power state when suspending to
disk.

I guess that for 99.5 % of the population, it is not an issue as the
monitor is usually plugged in the power supply of the computer and
power is cut when the computer shuts down. My monitor, however, is
directly plugged in the mains outlet and, after a suspend to disk, it
displays indefinitely an information box stating that it has no video
signal coming in.

The X server knows how to shutdown (DPMS) the screen afer some
inactivity, so I guess the kernel could do that while suspending. And it
would be very nice if it would. But I believe there is no device
driver handling the monitor, so I don't know where to do it.

Éric Brunet
