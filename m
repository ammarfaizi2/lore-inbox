Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbTGTWA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbTGTWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:00:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3059 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268685AbTGTWAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:00:53 -0400
Date: Mon, 21 Jul 2003 00:15:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: Walter Harms <WHarms@bfs.de>, linux-kernel@vger.kernel.org
Subject: Re: bug alpha configure linux-2.6.0-test1
Message-ID: <20030720221547.GH26422@fs.tum.de>
References: <vines.sxdD+KAO4zA@SZKOM.BFS.DE> <20030720020734.GA16983@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720020734.GA16983@eugeneteo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 10:07:34AM +0800, Eugene Teo wrote:
> Perhaps you might want to first copy your dotconfig
> to /path/to/linux-version/ then run make menuconfig,
> then save it, then compile it. 
> 
> > boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
> 
> This means that it is a new boolean symbol that your
> config don't have.

Nope, there is a bug (a Kconfig rule tried to assign m to a boolean 
symbol). Matthew Wilcox already posted a fix.

> > arch/alpha/defconfig:244: trying to assign nonexistent symbol SCSI_NCR53C8XX
> 
> I believe this is a symbol that exists in your config
> but the kernel doesn't have this in the menu anymore.

It exists in _defconfig_.

defconfig in the kernel sources should be updated. Besides the warning 
this issue is harmless.

> Eugene

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

