Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUGOLKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUGOLKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 07:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265885AbUGOLKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 07:10:33 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:56332 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265879AbUGOLKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 07:10:31 -0400
Date: Thu, 15 Jul 2004 13:10:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill drive_info
Message-ID: <20040715111028.GB3821@pclin040.win.tue.nl>
References: <20040714000810.GA7308@fs.tum.de> <20040714090159.GA3821@pclin040.win.tue.nl> <20040715025948.GA19092@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715025948.GA19092@fs.tum.de>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 04:59:48AM +0200, Adrian Bunk wrote:
> On Wed, Jul 14, 2004 at 11:01:59AM +0200, Andries Brouwer wrote:
> >...
> > > - 	drive_info = DRIVE_INFO;
> > 
> > Hmm. setup.c copies this info from where it was left after booting
> > to some safe place. You seem to think that this saving is not required.
> > Is it not?
> 
> - boot_params is __initdata
> - hd_init in legacy/hd.c is __init
> - legacy/hd.c can't be built modular
> 
> The situation is different in 2.4 where the new (possibly modular) IDE 
> driver also uses drive_info .

Yes, I see that this area (which used to be empty_zero_page)
is independent since 2.6.5.

So, maybe your patch is correct.

[Still, the patch brings knowledge about boot_params that earlier was
concentrated in head.S, setup.c, setup.h to elsewhere in the kernel. Ach.]

The doc file is still called zero-page.txt. One might add

0x228   4 bytes         command line buffer

and possibly rename it.

Andries
