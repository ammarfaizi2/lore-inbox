Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUHaP45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUHaP45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUHaP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:56:57 -0400
Received: from users.linvision.com ([62.58.92.114]:30680 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268745AbUHaP4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:56:54 -0400
Date: Tue, 31 Aug 2004 17:56:53 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
Message-ID: <20040831155653.GD17261@harddisk-recovery.com>
References: <20040830163931.GA4295@bitwizard.nl> <1093952715.32684.12.camel@localhost.localdomain> <20040831135403.GB2854@bitwizard.nl> <1093961570.597.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093961570.597.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:12:52PM +0100, Alan Cox wrote:
> On Maw, 2004-08-31 at 14:54, Rogier Wolff wrote:
> > How about we set the num-retries to 1, and increase to 8 for
> > "weird devices" (floppy, MO), and older drives. 
> 
> Disagree. I want it robust. If you want to set low retry counts then
> the user should do so for special cases like forensics.

The SCSI disk driver has been doing a single retry for quite some time
and it hasn't really bitten people. Why would the IDE disk driver be
different? The only case I can imagine a retry would be OK, is when we
get an UDMA CRC error (caused by bad cables).

(OK, for SCSI drives you have a lot more control about how a drive
should treat errors, but the kernel will not retry a block when the
drive reported it's bad.)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
