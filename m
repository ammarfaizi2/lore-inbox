Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUAHQyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUAHQyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:54:25 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:41231 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265557AbUAHQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:54:20 -0500
Date: Thu, 8 Jan 2004 16:54:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Message-ID: <20040108165414.A12233@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Thu, Jan 08, 2004 at 08:47:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 08:47:51AM -0800, Andrew Vasquez wrote:
> Yes, given the structure and form of recent patches, that certainly
> does seem to be the case - which from QLogic's standpoint (now) seems
> to be the proper path.  Just for clarification, given the structure of
> the driver now (failover completely separated), inclusion of the
> qla2xxx driver would exclude the following failover files:
> 
> 	qla_fo.c qla_foln.c qla_cfg.c qla_cfgln.c
> 
> correct?

 + qla_inioct.c qla_xioct.c

and the associated headers for both the ioctl and failover code, of course

> > - The odd ioctl set to the qla device...I'd much rather see something
> > more standard that all FC drivers can use.
> > 
> 
> Are you proposing to standardize a transport by which a user-space
> application communicates with a driver (beyond IOCTLs), or, are you
> suggesting there be some commonality in functional interfaces (i.e.
> SNIA) for all FC drivers?

the SNIA HBA-API spec is completely broken.  But we should try to support
a sanitized subset of the spec using the transport class work that's
currently discussed on linux-scsi.

