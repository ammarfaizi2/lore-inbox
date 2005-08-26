Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVHZOn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVHZOn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVHZOn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:43:58 -0400
Received: from cavan.codon.org.uk ([217.147.81.22]:48083 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S965061AbVHZOn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:43:58 -0400
Date: Fri, 26 Aug 2005 15:42:51 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: Telling Linux that a SATA device has gone away
Message-ID: <20050826144250.GA12816@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop (Dell Latitude D610) that has a removable DVD drive.  It
appears to be a PATA device, but is presented under ata_piix so behaves
like a SCSI drive. With the ACPI generic hotkey driver, I can get events
when it's removed and reinserted. Is there any way I can tell Linux that 
the device has been removed? hdparm's bus registration support 
(unsurprisingly) doesn't seem to work too well on sr0, but echoing 
"remove-single-device 1 0 0 0" to /proc/scsi/scsi doesn't seem to do 
anything either.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
