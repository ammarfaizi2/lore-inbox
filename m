Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUGOC7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUGOC7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUGOC7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:59:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46042 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265055AbUGOC7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:59:52 -0400
Date: Thu, 15 Jul 2004 04:59:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill drive_info
Message-ID: <20040715025948.GA19092@fs.tum.de>
References: <20040714000810.GA7308@fs.tum.de> <20040714090159.GA3821@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714090159.GA3821@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 11:01:59AM +0200, Andries Brouwer wrote:
>...
> > - 	drive_info = DRIVE_INFO;
> 
> Hmm. setup.c copies this info from where it was left after booting
> to some safe place. You seem to think that this saving is not required.
> Is it not?

- boot_params is __initdata
- hd_init in legacy/hd.c is __init
- legacy/hd.c can't be built modular

Did I miss something?

The situation is different in 2.4 where the new (possibly modular) IDE 
driver also uses drive_info .

> Andries

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

