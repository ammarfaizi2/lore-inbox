Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423058AbWJQLPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423058AbWJQLPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 07:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423054AbWJQLPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 07:15:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423042AbWJQLPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 07:15:42 -0400
Message-ID: <4534BB5B.6080002@garzik.org>
Date: Tue, 17 Oct 2006 07:15:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: brking@us.ibm.com
CC: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
References: <453027A9.3060606@us.ibm.com> <45340A62.7050406@us.ibm.com>
In-Reply-To: <45340A62.7050406@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian King wrote:
> This doesn't look like the right fix for the oops you were seeing. The
> SAS usage of libata has ap->scsi_host as NULL, which indicates that
> libata does not own the associated scsi_host. I'm concerned you may
> have broken some other code path by making this change. I think the correct
> fix may require removing the dependence of ap->scsi_host from
> ata_dev_config_ncq. 

Yep.  I had already mentioned this on IRC.

	Jeff


