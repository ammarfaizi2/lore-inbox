Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTJIMYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJIMYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:24:39 -0400
Received: from users.linvision.com ([62.58.92.114]:47322 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262116AbTJIMYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:24:33 -0400
Date: Thu, 9 Oct 2003 14:24:28 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: two sym53c8xx.o modules
Message-ID: <20031009122428.GF11525@bitwizard.nl>
References: <3F84AF3C.9050408@wanadoo.es> <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310090826290.2569-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 08:41:49AM -0300, Marcelo Tosatti wrote:
> On Thu, 9 Oct 2003, Xose Vazquez Perez wrote:
> > kernel 2.4 has two modules with *same name*:
> > /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.o
> > /lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx.o
> > 
> > "# modprobe sym53c8xx" tries to load sym53c8xx.o first and then sym53c8xx_2/sym53c8xx.o
> > bug or feature?
> > 
> > should be sym53c8xx_2/sym53c8xx.o renamed to sym53c8xx_2/sym53c8xx_2.o ?
> 
> One should not have both drivers loaded at the same time, so I think this
> is alright.

No, it's not allright. Modprobe can't distinguish between
sym53c8xx_2/sym53c8xx.o and sym53c8xx.o, you have to figure out the
full path and insmod one of them manually. Xose is right in that
sym53c8xx_2/sym53c8xx.o should be renamed in sym53c8xx_2/sym53c8xx_2.o.
Compare with aic7xxx and aic7xxx_old.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
