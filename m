Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWHBVUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWHBVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHBVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:20:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40597
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932206AbWHBVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:20:25 -0400
Date: Wed, 02 Aug 2006 14:20:34 -0700 (PDT)
Message-Id: <20060802.142034.94556682.davem@davemloft.net>
To: chris.leech@gmail.com, christopher.leech@intel.com
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org, neilb@suse.de,
       galak@kernel.crashing.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] I/OAT: remove CPU hotplug lock from net_dma_rebalance
From: David Miller <davem@davemloft.net>
In-Reply-To: <41b516cb0608011133r2332161dx4b43a845bfa74062@mail.gmail.com>
References: <41b516cb0608011133r2332161dx4b43a845bfa74062@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chris Leech" <christopher.leech@intel.com>
Date: Tue, 1 Aug 2006 11:33:02 -0700

>         if (net_dma_count == 0) {
>                 for_each_online_cpu(cpu)
> 
> rcu_assign_pointer(per_cpu(softnet_data.net_dma, cpu), NULL);
> -               unlock_cpu_hotplug();

Why is proper patch submission so damn difficult for people?
This patch is corrupted severely.

I'm fixing this up since it's such an obvious patch, but this
issue is getting really rediculious.  I can't believe how many
people submit line-wrapped, tab destroyed, patches these days.
