Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbTIDVrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTIDVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:47:55 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:53209 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265543AbTIDVry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:47:54 -0400
Subject: Re: [OOPS] 2.4.22 / HPT372N
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marko Kreen <marko@l-t.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904190426.GA31977@l-t.ee>
References: <20030904190426.GA31977@l-t.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062712012.22550.72.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 22:46:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 20:07, Marko Kreen wrote:
> As i used the pen&paper method for oops tracking i dont have
> full oops.
> 
> In hpt366.c function hpt372_tune_chipset line 427:
> 
>        list_conf = pci_bus_clock_list(speed,
>                         (struct chipset_bus_clock_list_entry *)

I thought I'd fixed that crash case but it seems your system is over
clocked.

FREQ: 85 PLL: 41
hpt: no known IDE timings,

so your PCI bus is running at somewhere about 35Mhz and outside the
drivers safe threshold. 

Alan
