Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUEMIDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUEMIDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUEMIDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:03:10 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:51716 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S263928AbUEMIDE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:03:04 -0400
Date: Thu, 13 May 2004 10:05:06 +0200 (CEST)
Message-Id: <200405130805.i4D856M0055748@zone3.gcu-squad.org>
To: jdgaston@snoqualmie.dp.intel.com
Subject: Re: [PATCH] ICH6/6300ESB i2c support
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.12 (On: webmail.gcu.info)
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jason,

A few comments on your patch:

> This patch adds DID support for ICH6 and 6300ESB to i2c-i801.c(SMBus).  In
> order to add this support I needed to patch pci_ids.h with the SMBus DID's.
> To keep things orginized I renumbered the ICH6 and ESB entries in pci_ids.h. 
> I then patched the piix IDE and i810 audio drivers to reflect the updated
> #define's.  I also removed an error from irq.c; there was a reference to a
> 6300ESB DID that does not exist.  This patch is against the 2.6.6 kernel.

To me, there are two different things here and you should split your
patch accordingly for clarity.  The renumbering of the entries should go
in a first patch, then the new devices support in i2c-i801 in a second.

I would also suggest that you follow the common habit to name the Intel
82801 chips after their numerical name (82801AA. 82801BA, etc...) and
not their nickname (ICH, ICH2...) in both the entries and the comments. 
Not that it is absolulety better, but that's the way we did so far, so
why change now?

I would appreciate it if you could submit a similar patch for the 2.4
version of the i2c-i801 driver as held in the lm_sensors project.

Thanks.

Jean Delvare


--
Jean "Khali" Delvare
http://khali.linux-fr.org/
