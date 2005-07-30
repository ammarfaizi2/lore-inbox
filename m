Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVG3Rcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVG3Rcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVG3Rcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:32:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:14304 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263069AbVG3Rcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:32:46 -0400
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance
	Initiator
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
In-Reply-To: <429E15CD.2090202@yahoo.com>
References: <429E15CD.2090202@yahoo.com>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 12:32:42 -0500
Message-Id: <1122744762.5055.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 13:08 -0700, Alex Aizman wrote:
> This is open-iscsi/linux-iscsi-5 Initiator. This submission is ready for
> inclusion into mainline kernel.

OK, I tried to put this into scsi-misc.

FIB has taken your netlink number, so I changed it to 32

__nlm_put() has had an updated prototype, which I can fix (although I'm
not sure you're supposed to be using this function...)

I can't fix up the compile errors in iscsi_tcp.c:

  CC [M]  drivers/scsi/iscsi_tcp.o
drivers/scsi/iscsi_tcp.c: In function `iscsi_hdr_extract':
drivers/scsi/iscsi_tcp.c:160: warning: implicit declaration of function
`iscsi_cnx_error'
drivers/scsi/iscsi_tcp.c:161: error: `ISCSI_ERR_PDU_GATHER_FAILED'
undeclared (first use in this function)
drivers/scsi/iscsi_tcp.c:161: error: (Each undeclared identifier is
reported only once
drivers/scsi/iscsi_tcp.c:161: error: for each function it appears in.)
drivers/scsi/iscsi_tcp.c: In function `iscsi_tcp_state_change':
drivers/scsi/iscsi_tcp.c:1005: error: `ISCSI_ERR_CNX_FAILED' undeclared
(first use in this function)
drivers/scsi/iscsi_tcp.c: In function `iscsi_sendhdr':
drivers/scsi/iscsi_tcp.c:1092: error: `ISCSI_ERR_CNX_FAILED' undeclared
(first use in this function)
drivers/scsi/iscsi_tcp.c: In function `iscsi_sendpage':
drivers/scsi/iscsi_tcp.c:1141: error: `ISCSI_ERR_CNX_FAILED' undeclared
(first use in this function)
drivers/scsi/iscsi_tcp.c: In function `iscsi_data_xmit_more':
drivers/scsi/iscsi_tcp.c:1707: error: `STOP_CNX_RECOVER' undeclared
(first use in this function)
drivers/scsi/iscsi_tcp.c: At top level:
[...]

Do you have an updated driver that will work in the current tree?

Thanks,

James


