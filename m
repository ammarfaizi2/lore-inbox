Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265780AbUGMUhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUGMUhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGMUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:37:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58855 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265800AbUGMUha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:37:30 -0400
Date: Tue, 13 Jul 2004 13:37:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: panic from isp1020
Message-ID: <135380000.1089751023@flay>
In-Reply-To: <133950000.1089750625@flay>
References: <133950000.1089750625@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The EIP according to addr2line is:
> Cmnd->result = isp1020_return_status(sts);
> 	(drivers/scsi/qlogicisp.c:1048)
> 
> 0xc01eb588 <isp1020_intr_handler+572>:  mov    %eax,0x154(%esi)
> 
> but esi is 0 ....

ie. Cmnd = NULL. Which was set above by:

Cmnd = hostdata->cmd_slots[cmd_slot];

M.

