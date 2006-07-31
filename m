Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWGaKuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWGaKuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWGaKuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:50:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45982 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751513AbWGaKuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:50:01 -0400
Subject: Re: [2.6.18-rc2-mm1] libata: DMA speed too slow for cdrecord
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20060729235431.322ea6d3@werewolf.auna.net>
References: <20060729235431.322ea6d3@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 31 Jul 2006 12:09:01 +0100
Message-Id: <1154344141.7230.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-29 am 23:54 +0200, ysgrifennodd J.A. Magallón:
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14

Chip configuration reports OK
> scsi0 : ata_piix
> ata1.00: ATAPI, max UDMA/33
> ata1.01: ATAPI, max MWDMA0, CDB intr
> ata1.00: configured for PIO3
> ata1.01: configured for PIO3

Your tree appears to have the old speed setting code in it not the new
speed setting code. As a result of this it tries to set both to MWDMA0
which isn't available on the ICH chips and so falls back to PIO3.


