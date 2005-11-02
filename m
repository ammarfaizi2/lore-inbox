Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVKBSrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVKBSrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVKBSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:47:12 -0500
Received: from pat.qlogic.com ([198.70.193.2]:59850 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S965173AbVKBSrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:47:12 -0500
Date: Wed, 2 Nov 2005 10:47:05 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, support@qlogic.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device Driver
Message-ID: <20051102184705.GD5889@plapn>
References: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com> <20051102080711.GB626@plapn> <20051102082142.GW5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102082142.GW5856@shell0.pdx.osdl.net>
Organization: QLogic Corporation
X-Operating-System: Darwin 8.2.0 powerpc
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Nov 2005 18:47:07.0294 (UTC) FILETIME=[D32263E0:01C5DFDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2005, Chris Wright wrote:

> * Andrew Vasquez (andrew.vasquez@qlogic.com) wrote:
> > On Wed, 02 Nov 2005, Ashutosh Naik wrote:
> > 
> > > This patch fixes the fact that although the scsi_transport_fc.h header
> > > file is not included in qla_def.h, we still reference the function
> > > fc_remote_port_unlock in the qlogic  ISP2x00 device driver ,
> > > qla2xxx/qla_rscn.c
> > 
> > Perhaps for the stable tree (2.6.14.x) this fix is appropriate.  The
> > scsi-misc-2.6.git tree already has codes which address this issue.
> 
> It's preferable to have that fix pending in scsi-misc for -stable.

Sure.  But, the interface changes present in scsi-misc-2.6, notably:

http://kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=19a7b4aebf9ad435c69a7e39930338499af4d152

obviate the need for the explicit '#include' -- there are no longer
any explicit calls to the fc_remote_port_*() functions within
qla_rscn.c.

Regards,
Andrew Vasquez
