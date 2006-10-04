Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030691AbWJDR4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbWJDR4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbWJDR4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:56:23 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:2755 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030691AbWJDR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:56:21 -0400
Subject: Re: [Patch 1/6] megaraid_sas: FW transition and q size changes
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sumant Patro <sumantp@lsil.com>
Cc: linux-scsi@vger.kernel.org, akpm@osdl.org, hch@lst.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <1159903729.5618.7.camel@dumbo>
References: <1159903729.5618.7.camel@dumbo>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 12:56:11 -0500
Message-Id: <1159984571.3437.22.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 12:28 -0700, Sumant Patro wrote:
> Resubmitting with one addition (item f mentioned below)
> 
> This patch has the following enhancements :
>         a. handles new transition states of FW to support controller hotplug. 
>         b. It reduces by 1 the maximum cmds that the driver may send to FW. 
>         c. Sends "Stop Processing" cmd to FW before returning failure from reset routine
>         d. Adds print in megasas_transition routine
>         e. Sends "RESET" flag to FW to do a soft reset of controller 
> to move from Operational to Ready state.
> 	f. Sending correct pointer (cmd->sense) to pci_pool_free 
>           
>         This patch has been generated on latest scsi-misc git.
> 
> Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

Every one of these patches had extra whitespace at the end of several
lines.  This is a sample from the first patch:

Adds trailing whitespace.
.dotest/patch:21:       if (fw_state != MFI_STATE_READY) 
Adds trailing whitespace.
.dotest/patch:44:               case MFI_STATE_BOOT_MESSAGE_PENDING:
Adds trailing whitespace.
.dotest/patch:85:        * Reduce the max supported cmds by 1. This is
to ensure that the 

Could you please try to ensure it doesn't happen in future ... it's time
consuming to clean it all up again.

Thanks,

James


