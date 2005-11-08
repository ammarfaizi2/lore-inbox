Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVKHQHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVKHQHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVKHQHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:07:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15293 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030231AbVKHQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:07:15 -0500
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520
	SATA (HPT372N)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Johan Palmqvist <johan.palmqvist@inap.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <436FB350.6020309@inap.se>
References: <436FB350.6020309@inap.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 16:37:56 +0000
Message-Id: <1131467876.25192.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-07 at 21:04 +0100, Johan Palmqvist wrote:
> When used with a HighPoint RocketRAID 1520 SATA (HPT372N) the hpt366 
> driver, compiled as a module, oops'es on loading. If the driver is 
> compiled into the kernel it causes a kernel panic on boot while 
> detecting the card. Kernels tested: 2.6.13.2, 2.6.13.4 and 2.6.14. 
> Please CC any answers to me since I'm not on the list.

I'm working on this with the new libata drivers. The list of what is
broken in the old driver for 372N/302N is rather large as they are
actually very different to the other chips.

I've got the correct timing tables and PLL tune information for the 302N
now which appears to be very similar if not identical for these needs so
if someone wants to hack the old drivers/ide/pci driver a bit I can
provide reasonably accurate chip id and chip pll base information to
enable a fix.

PS: Anyone got a 371N (specifically 371N) can send me the pci id and
rev.

