Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268757AbUILRNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268757AbUILRNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUILRNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:13:15 -0400
Received: from users.linvision.com ([62.58.92.114]:41603 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268757AbUILRNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:13:04 -0400
Date: Sun, 12 Sep 2004 19:13:00 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in md write barrier support?
Message-ID: <20040912171300.GA14369@bitwizard.nl>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de> <1094650500.11723.32.camel@localhost.localdomain> <20040908154608.GN2258@suse.de> <1094682098.12280.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094682098.12280.19.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 11:21:39PM +0100, Alan Cox wrote:
> I2O defines cache flush very losely. It flushes the cache and returns
[...]
> write 1, 2, 3, 4 , 40, 41, flush cache, write 5, 6, 100

> it'll write 1,2,3,4,5,6, 40, 41, report flush cache complete. 

which, if 5,6 are the metadata updates beloging to logfile writes
40,41 and the system powers down between 5 and 41 spells trouble. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
