Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTIVLdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTIVLdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:33:55 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43457 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263110AbTIVLdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:33:54 -0400
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030921201133.GE24897@neo.rr.com>
References: <20030921200935.GB24897@neo.rr.com>
	 <20030921201133.GE24897@neo.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064230334.8592.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 12:32:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-21 at 21:11, Adam Belay wrote:
> # --------------------------------------------
> # 03/09/21	ambx1@neo.rr.com	1.1357
> # [PNP] remove DMA 0 restrictions
> # 
> # The original argument for blocking DMA 0 was to avoid conflicts with
> # "memory refresh"  but such configurations are only found on very old
> # 8-bit systems that are likely not supported by the linux kernel. 

DMA0 is used by lots of 386/486 era systems for memory refresh. It is
also "borrowed" by some other systems that know it isnt available to the
OS. There are a couple of heuristics I've seen suggested by vendors of
things like sound cards

1.	Check the PnPBIOS information (never looked into this myself)
2.	Assume DMA 0 is free if the machine has a PCI bus detected
3.	Read the DMA 0 counter a few times. If it is continually 	changing
don't use DMA 0

#2 is certainly a good idea IMHO, I don't know how well the others work.
