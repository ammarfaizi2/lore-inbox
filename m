Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUEIPOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUEIPOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbUEIPOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 11:14:45 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264346AbUEIPOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 11:14:43 -0400
Date: Sun, 9 May 2004 04:00:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040509020017.GA5621@elf.ucw.cz>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506084918.B12990@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static int ide_disk_notify_reboot (struct notifier_block *this, unsigned long event, void *x)
> > +{
> > +	ide_hwif_t *hwif;
> > +	ide_drive_t *drive;
> > +	int i, unit;
> > +	
> > +	switch (event) {
> > +		case SYS_HALT:
> > +		case SYS_POWER_OFF:
> > +			break;
> > +		default:
> > +			return NOTIFY_DONE;
> > +	}
> 
> Please don't use reboot notifiers in new driver code.  The driver
> model has a ->shutdown method for that.

Also you want to run this on machine entering S3 or suspend-to-disk,
too...

								Pavel
-- 
When do you have heart between your knees?
