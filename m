Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVAaMnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVAaMnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVAaMnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:43:45 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:4839 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261176AbVAaMnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:43:35 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
In-Reply-To: <41FE24F5.5070906@suse.de>
References: <41FE24F5.5070906@suse.de>
Date: Mon, 31 Jan 2005 12:43:18 +0000
Message-Id: <1107175398.25905.32.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing - if swsusp_read() fails (eg, due to there not actually being
a suspend image), the processes will have been frozen but not woken up.
The failure path in software_resume needs to call thaw_processes before
exiting.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

