Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSIFDtw>; Thu, 5 Sep 2002 23:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSIFDtw>; Thu, 5 Sep 2002 23:49:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318272AbSIFDtw>;
	Thu, 5 Sep 2002 23:49:52 -0400
Date: Thu, 05 Sep 2002 20:47:21 -0700 (PDT)
Message-Id: <20020905.204721.49430679.davem@redhat.com>
To: hadi@cyberus.ca
Cc: tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
References: <200209051830.g85IUMdH096254@tempest.prismnet.com>
	<Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jamal <hadi@cyberus.ca>
   Date: Thu, 5 Sep 2002 16:59:47 -0400 (EDT)
   
   I would think shoving the data down the NIC
   and avoid the fragmentation shouldnt give you that much significant
   CPU savings.

It's the DMA bandwidth saved, most of the specweb runs on x86 hardware
is limited by the DMA throughput of the PCI host controller.  In
particular some controllers are limited to smaller DMA bursts to
work around hardware bugs.

Ie. the headers that don't need to go across the bus are the critical
resource saved by TSO.

I think I've said this a million times, perhaps the next person who
tries to figure out where the gains come from can just reply with
a pointer to a URL of this email I'm typing right now :-)
