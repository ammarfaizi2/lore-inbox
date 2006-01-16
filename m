Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWAPA1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWAPA1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWAPA1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:27:07 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:53445 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932140AbWAPA1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:27:07 -0500
Date: Mon, 16 Jan 2006 00:27:03 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Userspace interface breakage in power/state
Message-ID: <20060116002703.GA4769@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent, without the wrong address for lkml)

In older kernels, power/state for PCI devices took a PCI power state as 
an argument and so "3" was an entirely sensible thing to echo into it. 
In current kernels, it hits a BUG() in pci_choose_state and things blow 
up.

While I realise that the former interface was broken and wrong, would it 
be possible to move to a new one without breaking existing code? 
-- 
Matthew Garrett | mjg59@srcf.ucam.org

-- 
Matthew Garrett | mjg59@srcf.ucam.org
