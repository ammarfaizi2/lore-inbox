Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDQOhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTDQOhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:37:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:9735 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261595AbTDQOhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:37:12 -0400
Subject: Re: [ANNOUNCE]: version 2.00.3 megaraid driver for 2.4.x and 2.5.67
	kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Mukker, Atul" <atulm@lsil.com>, "'alan@redhat.com'" <alan@redhat.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>,
       "'linux-megaraid-announce@dell.com'" 
	<linux-megaraid-announce@dell.com>
In-Reply-To: <20030417133820.A12503@infradead.org>
References: <0E3FA95632D6D047BA649F95DAB60E570185F10F@EXA-ATLANTA.se.lsil.com> 
	<20030417133820.A12503@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Apr 2003 09:41:59 -0500
Message-Id: <1050590521.2026.76.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-17 at 07:38, Christoph Hellwig wrote:
> On Wed, Apr 16, 2003 at 04:34:22PM -0400, Mukker, Atul wrote:
> > New megaraid driver 2.00.3 is now available at
> > ftp://ftp.lsil.com/pub/linux-megaraid For this driver, a patch is also
> > available for 2.5.67 kernel.
[...]

I'm not inclined to force style changes in any drivers with active
maintainers on the grounds that we already have much worse offenders in
the tree (and style changes do make merging a pain).

I counted one serious issue:

The try_module_get problem

One future compatibility issue:

->detect moved to scsi_add_host (for the device model).

One issue that would improve the driver internally:

move hba_soft_state array to dynamic ->hostdata

plus a list of other more style related issues.

I'll fix up the first one, Atul, can you take the other two for a future
patch (the others Christoph mentions might be nice, too...)?

James


