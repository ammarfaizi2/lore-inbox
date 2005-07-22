Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVGVJck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVGVJck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGVJc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:32:29 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6840 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261222AbVGVJbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:31:47 -0400
Date: Fri, 22 Jul 2005 11:31:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andre Eisenbach <int2str@gmail.com>
cc: bert hubert <bert.hubert@netherlabs.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
In-Reply-To: <7f800d9f0507220016d8c26e6@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507221127470.11709@yvahk01.tjqt.qr>
References: <20050722034135.GA21201@outpost.ds9a.nl> <7f800d9f0507220016d8c26e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm currently at OLS and presented http://ds9a.nl/diskstat yesterday, which
>> also references your ancient 'fboot' program.
>
>So checkout initng for your tests. It's a highly parallelized init
>system which seriously speeds up boot. It also keeps the disks much
>busier during boot and might help your testing.

Sharing my impression:
The downside of parallelization within a runlevel change (to keep it general) 
is that the disk can get too active, and if you're starting/stopping a memory 
intensive process, you're almost stuck in swapping in and out because 
everyone wants a piece of mapped physram.


Jan Engelhardt
-- 
