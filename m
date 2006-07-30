Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWG3Nrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWG3Nrg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWG3Nrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:47:36 -0400
Received: from mail.gmx.net ([213.165.64.21]:22486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932269AbWG3Nrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:47:35 -0400
X-Authenticated: #448092
Message-ID: <44CCB873.5010407@gmx.de>
Date: Sun, 30 Jul 2006 15:47:31 +0200
From: Joachim Schlichting <mirth@gmx.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: added device ids to get pata and sata controller to work on an asus
 m2v motherboard
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
To get my asus m2v onboard controllers to work, i added the following 
lines (tested with 2.6.16.X kernels, but the device-ids are not included 
in the actual 2.6.17.X, too):

in
drivers/scsi/sata_via.c
to
static const struct pci_device_id svia_pci_tbl[]

{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },

and in
drivers/ide/pci/via82cxxx.c
to
via_isa_bridges[]

{ "unknown",     PCI_DEVICE_ID_VIA_82C586_1,     0x00, 0x07, 
VIA_UDMA_133 | VIA_BAD_AST },


After this changes everything is working absolutely fine.
I hope I could help and have sent this bug report to the right place.
Regards,
Joachim Schlichting
