Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758841AbWK2NQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbWK2NQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbWK2NQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:16:26 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:56738 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1758839AbWK2NQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:16:25 -0500
Date: Wed, 29 Nov 2006 06:16:24 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/scsi_error.c should #include "scsi_transport_api.h"
Message-ID: <20061129131624.GV14076@parisc-linux.org>
References: <20061129100422.GL11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129100422.GL11084@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:04:22AM +0100, Adrian Bunk wrote:
> +#include "scsi_transport_api.h"

scsi_transport_api.h is a weird little file.  It's not included by
anything in the drivers/scsi directory, only
drivers/scsi/libsas/sas_scsi_host.c:#include "../scsi_transport_api.h"
drivers/ata/libata-eh.c:#include "../scsi/scsi_transport_api.h"

To me, that says it should be living in include/scsi/ somewhere ...
maybe just put the one function prototype into scsi_eh.h?
