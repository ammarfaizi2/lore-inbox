Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130759AbRABKVQ>; Tue, 2 Jan 2001 05:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbRABKVG>; Tue, 2 Jan 2001 05:21:06 -0500
Received: from quechua.inka.de ([212.227.14.2]:15406 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130759AbRABKUt>;
	Tue, 2 Jan 2001 05:20:49 -0500
Date: Tue, 2 Jan 2001 10:49:57 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-rerelease] driver/net/Makefile bug (pcmcia)
Message-ID: <20010102104957.A1949@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modules for pcmcia network cards are not build by the kernel.

subdir-$(CONFIG_PCMCIA) += pcmcia

should be

ifeq ($(CONFIG_PCMCIA),y)
  subdir-y += pcmcia
  subdir-m += pcmcia
endif

because CONFIG_PCMCIA=y but CONFIG_PCMCIA_SOMENETWORKDRIVER=m
maybe even bett is useing CONFIG_NET_PCMCIA instead of CONFIG_PCMCIA.

regards, andreas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
