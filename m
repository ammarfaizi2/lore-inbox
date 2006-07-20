Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWGTKR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWGTKR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWGTKR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:17:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26632 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030253AbWGTKR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:17:28 -0400
Date: Thu, 20 Jul 2006 12:17:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, Stefan Schmidt <zaphodb@zaphods.net>
Subject: 2.6.18-rc1-mm2: drivers/fc4/fc.c compile error
Message-ID: <20060720101727.GD25367@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060714190813.GC3633@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714190813.GC3633@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 09:08:13PM +0200, Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc1-mm1:
> >...
> >  git-scsi-rc-fixes.patch
> >...
> >  git trees.
> >...
> 
> Christoph, this is caused by your "hide EH backup data outside the scsi_cmnd" 
> patch:
>...

Another one (reported by Stefan Schmidt):

<--  snip  -->

...
  CC [M]  drivers/fc4/fc.o
drivers/fc4/fc.c: In function 'fcp_scsi_receive':
drivers/fc4/fc.c:432: error: 'Scsi_Cmnd' has no member named 'buffer'
drivers/fc4/fc.c: In function 'fcp_scsi_queue_it':
drivers/fc4/fc.c:813: error: 'Scsi_Cmnd' has no member named 'buffer'
make[2]: *** [drivers/fc4/fc.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

