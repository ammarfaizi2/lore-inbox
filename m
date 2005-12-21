Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVLUL3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVLUL3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLUL3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:29:05 -0500
Received: from tag.witbe.net ([81.88.96.48]:40837 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932370AbVLUL3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:29:04 -0500
Message-Id: <200512211128.jBLBSoD29257@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Date: Wed, 21 Dec 2005 12:28:52 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20051221111852.GA7698@havoc.gtf.org>
Thread-Index: AcYGIFkWe/O/llenQKCXwzviBWePHgAAP7Ow
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> Apply all the Red Hat-specific patches that you ditched, when you
> switched to a vanilla kernel...  The patch that supported combined
> mode for you is in there.
> 

Just had a quick look at everything that contains "SATA" or ICH in the
patch list from RedHat, and there are two :
 - one concerns pci_quirks and pci_irqs,
 - one concerns ata_piix.c and libata.c

If the first one seems quite OK, the second one implies going back to
libata 0.93 and switching to the "old" ata_piix.c, as the one in the
2.4.32 kernel contains :
	if (combined) {
		...
		return ENODEV;
	}
thus clearly preventing devices from being detected when combined
more is there.

Do you really think such a big step back is required ?

Regards,
Paul

