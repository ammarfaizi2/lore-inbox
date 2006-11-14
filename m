Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966447AbWKNXHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966447AbWKNXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966448AbWKNXHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:07:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:25043 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966447AbWKNXHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:07:06 -0500
Message-ID: <455A4C17.5000902@garzik.org>
Date: Tue, 14 Nov 2006 18:07:03 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] sas_ata: satisfy libata qc function locking requirements
References: <455A395D.1060407@us.ibm.com>
In-Reply-To: <455A395D.1060407@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> ata_qc_complete and ata_sas_queuecmd require that the port lock be held
> when they are called.  sas_ata doesn't do this, leading to BUG messages
> about qc tags newly allocated qc tags already being in use.  This patch
> fixes the locking, which should clean up the rest of those messages.
> 
> So far I've tested this against an IBM x206m with two SATA disks with no
> BUG messages and no other signs of things going wrong, and the machine
> finally passed the pounder stress test.  The patch is against jejb's
> aic94xx-sas tree.
> 
> --
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

heh, yeah, proper locking helps :)

Glad to hear the progress.  Adaptec just sent me a cable that will allow 
me to use my Razor card as a SATA controller, so I can finally start 
testing that.

	Jeff



