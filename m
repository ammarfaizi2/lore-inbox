Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUH2CbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUH2CbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUH2CbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:31:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267601AbUH2CbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:31:05 -0400
Message-ID: <41313FDA.6080009@pobox.com>
Date: Sat, 28 Aug 2004 22:30:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [gmulas@ca.astro.it: kernel-source-2.4.27: libata.o not compiled
 as module]
References: <20040829021638.GA29207@darjeeling.triplehelix.org>
In-Reply-To: <20040829021638.GA29207@darjeeling.triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> forwarded 268188 jgarzik@pobox.com
> thanks
> 
> Hi Jeff,
> 
> It seems that libata.o isn't getting built when some drivers depending
> on libata are built as modules and others as built in, on 2.4.27. If
> they're either all built in, or all modules, everything builds fine.
> 
> Would you have an idea on this matter?



> CONFIG_SCSI_SATA=y
> CONFIG_SCSI_SATA_SVW=m
> CONFIG_SCSI_SATA_PROMISE=m
> CONFIG_SCSI_SATA_SX4=m
> CONFIG_SCSI_SATA_SIL=m
> CONFIG_SCSI_SATA_SIS=m
> CONFIG_SCSI_SATA_VIA=m
> CONFIG_SCSI_SATA_VITESSE=y


Everything is working just fine, from looking at the output.

CONFIG_SCSI_SATA_VITESSE is set to 'y', which means that libata is built 
into the kernel rather than as a module, because 
CONFIG_SCSI_SATA_VITESSE is built into the kernel, and libata is a 
dependency.

Because the dependency (libata.o) is built into the kernel, no kernel 
module will be produced.

	Jeff


