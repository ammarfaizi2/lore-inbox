Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVHAJT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVHAJT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVHAJT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:19:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:59087 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261168AbVHAJTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:19:25 -0400
Message-ID: <42EDE918.9040807@gmx.net>
Date: Mon, 01 Aug 2005 11:19:20 +0200
From: Otto Meier <gf435@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Driver for sata adapter promise sata300 tx4
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:a9159ed0296f17902404cf1c2ac7671c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This card use the sata chip pdc 40718 (as of my card)
the lastest sata_promise kernel with sata promise patch driver doesn't 
recognise
this card.

I added the following line to static struct pci_device_id 
pdc_ata_pci_tbl[]  in sata_promise.c:

        { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },

and the card was recognised and seam to work without errors so far.

bilding a soft raid5 on it and moving data doesn't broke it.

It would be interesting to hear from the guru's if this is ok to do?.

Otto

