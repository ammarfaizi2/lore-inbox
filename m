Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757931AbWKYP5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931AbWKYP5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757930AbWKYP5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 10:57:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56040 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757928AbWKYP5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 10:57:20 -0500
Date: Sat, 25 Nov 2006 16:03:42 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
Message-ID: <20061125160342.4e9ddef0@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/33

Looks like a cable detect error.

> scsi1 : pata_via
> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: port failed to respond (30 secs, Status 0xff)
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)
> ata2: SRST failed (err_mask=0x100)
> ata2: softreset failed, retrying in 5 secs
> ata2: SRST failed (status 0xFF)

This is a known bug in the libata core at the moment

> BTW: is it possible to do something with this annoying long delay with 
> the "port is slow to respond, please be patient" message? :)

No, but it does appear to be a bug. Can you send me an lspci -vvxxx

Alan

