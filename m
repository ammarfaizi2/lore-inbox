Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVKBTPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVKBTPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVKBTPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:15:54 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:47298 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965185AbVKBTPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:15:54 -0500
Subject: Re: [stable] Re: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device
	Driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Ashutosh Naik <ashutosh.naik@gmail.com>, support@qlogic.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       stable@kernel.org
In-Reply-To: <20051102082142.GW5856@shell0.pdx.osdl.net>
References: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com>
	 <20051102080711.GB626@plapn>  <20051102082142.GW5856@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 10:57:39 -0800
Message-Id: <1130957859.3259.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 00:21 -0800, Chris Wright wrote:
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

This is the fix that's queued in scsi-misc for this:

http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=aa353de649f1ba05a71b2f5b8eb1e99632ab54eb

But since this is only a compile warning, does it really warrant fixing
in the stable tree?

James


