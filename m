Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbVBFG7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbVBFG7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbVBFG7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:59:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7608 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S267518AbVBFGzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:55:38 -0500
Message-ID: <4205BF5B.7050006@pobox.com>
Date: Sun, 06 Feb 2005 01:55:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peer.Chen@uli.com.tw
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andrebalsa@mailingaddress.org, Clear.Zhang@uli.com.tw,
       Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw
Subject: Re: [patch] scsi/ahci: Add support for ULi M5287
References: <OF3919B280.9034BA70-ON48256FA0.002238C1@uli.com.tw>
In-Reply-To: <OF3919B280.9034BA70-ON48256FA0.002238C1@uli.com.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peer.Chen@uli.com.tw wrote:
> Hi,Jeff:
> I think you are not necessary add the m5287 support to ahci.c now, the code
> I add is to
> correct the two bugs of our controller, now we have designed a new AHCI
> controller name M5288(device id is 0x5288),
> it work perfectly with the linux ahci driver only add the PCI ID to ahci.c.

Thanks, I will add this PCI ID to ahci.c.


> Another question,if the SATA SCSI driver and AHCI driver both support the
> same controller, which driver
> has the priority in linux.

Two answers:

a) For the upstream kernel -- when the drivers are built into the kernel
-- the order in which the drivers are listed in drivers/scsi/Makefile
affects the probe order (priority).  When the drivers are built as
kernel modules, the contents of /etc/modprobe.conf (or /etc/modules.conf
for kernel 2.4.x) determines which driver to load.

b) For distributors (Red Hat, SuSE, Mandrake, etc.), the installer
engineers at each company choose which driver to load.

To simplify matters, it is recommended to avoid situations where
multiple drivers have the same PCI ID listed.  The "more advanced"
driver (AHCI) is preferred of course ;-)

Regards,

	Jeff


