Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbTDAQ5S>; Tue, 1 Apr 2003 11:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbTDAQ5R>; Tue, 1 Apr 2003 11:57:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262650AbTDAQ5M>;
	Tue, 1 Apr 2003 11:57:12 -0500
Date: Tue, 01 Apr 2003 09:04:10 -0800 (PST)
Message-Id: <20030401.090410.84707397.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] net: severe bug in icmp stats
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030401185707.A955@jurassic.park.msu.ru>
References: <20030401185707.A955@jurassic.park.msu.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Tue, 1 Apr 2003 18:57:07 +0400

   I believe many of those weird crash reports with recent 2.5
   kernels can be explained by wrong pointer arithmetic in
   ICMP_INC_STATS_xx_FIELD macros.
   
   (*((long *)((void *)ptr) + offt))++
   
Thanks a lot Ivan, patch applied.
