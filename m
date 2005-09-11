Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVIKJq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVIKJq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVIKJq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:46:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53393 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964841AbVIKJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:46:58 -0400
Date: Sun, 11 Sep 2005 10:46:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <ltuikov@yahoo.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050911094656.GC5429@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 07:44:54PM -0700, Luben Tuikov wrote:
> > this one completely duplicates the
> > mid-layer infrastructure for handling devices with Logical Units.
> 
> No, it does *not*.  James, you have _stop_ spreading FUD, relying
> that other people have not read the SCSI Core code.
> 
> See here:
>     SCSI Core has *no representation* of a SCSI Device with a
> SCSI Target Port.

struct scsi_target

> I've _clearly_ outlined that in the comments of the code,
> which you _conveniently_ did _not_ cut and paste here.

 * Discover logical units present in the SCSI device.  I'd like this
 * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
 * device with a SCSI Target port".  A SCSI device with a SCSI Target
 * port is a device which the _transport_ found, but other than that,
 * the transport has little or _no_ knowledge about the device.
 * Ideally, a LLDD would register a "SCSI device with a SCSI Target
 * port" with SCSI Core and then SCSI Core would do LU discovery of
 * that device.

So what does this mean except "Luben tries to impress everyone with
standards gibberish, at the same time ignoring we soluitions that
work despite maybe not 100% elegant".

Sure, we'd like to move away from needing the ->id target id specifier.
But right now we need it, even you're code sets it in over-complicated
ways.  But if you send a nice patch to get rid everyone will be happy.

