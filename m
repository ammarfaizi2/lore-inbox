Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTFMGNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTFMGNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:13:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62900 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265163AbTFMGNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:13:50 -0400
Date: Thu, 12 Jun 2003 23:22:49 -0700 (PDT)
Message-Id: <20030612.232249.104032251.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527222712.GB1453@dualathlon.random>
References: <20030527115314.GU3767@dualathlon.random>
	<20030527.150449.08322270.davem@redhat.com>
	<20030527222712.GB1453@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 28 May 2003 00:27:12 +0200

   I see your point, please try with 2.4.21rc4aa1 or with this patch:
   
   	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc4aa1/00_ksoftirqd-max-loop-networking-1
   
   you can put a printk in the ksoftirqd loop and tune the N until it
   behaves as you want.

Ingo's specweb testing indicated that a value somewhere between 8 and
10 appear optimal.

I've pushed this change into Andrew's -mm 2.5.x patch set.
