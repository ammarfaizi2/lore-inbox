Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUCPVwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCPVwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:52:33 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:62676 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261731AbUCPVwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:52:31 -0500
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
From: James Bottomley <James.Bottomley@steeleye.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040316135155.GI2785@mschwid3.boeblingen.de.ibm.com>
References: <20040316135155.GI2785@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Mar 2004 16:52:23 -0500
Message-Id: <1079473944.1804.21.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 08:51, Martin Schwidefsky wrote:
> +ZFCP_DEFINE_SCSI_ATTR(hba_id, "%s\n", zfcp_get_busid_by_unit(unit));
> +ZFCP_DEFINE_SCSI_ATTR(wwpn, "0x%016llx\n", unit->port->wwpn);
> +ZFCP_DEFINE_SCSI_ATTR(fcp_lun, "0x%016llx\n", unit->fcp_lun);

These attributes all properly belong in the fibrechannel transport
class, could you look at moving them over, please.

James


