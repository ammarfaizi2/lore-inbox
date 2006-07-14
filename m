Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWGNTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWGNTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWGNTIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:08:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422679AbWGNTIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:08:14 -0400
Date: Fri, 14 Jul 2006 21:08:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: 2.6.18-rc1-mm2: drivers/scsi/NCR53C9x.c compile error
Message-ID: <20060714190813.GC3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
>  git-scsi-rc-fixes.patch
>...
>  git trees.
>...

Christoph, this is caused by your "hide EH backup data outside the scsi_cmnd" 
patch:

<--  snip  -->

...
  CC      drivers/scsi/NCR53C9x.o
drivers/scsi/NCR53C9x.c: In function ‘esp_get_dmabufs’:
drivers/scsi/NCR53C9x.c:914: error: ‘Scsi_Cmnd’ has no member named ‘buffer’
drivers/scsi/NCR53C9x.c: In function ‘esp_should_clear_sync’:
drivers/scsi/NCR53C9x.c:2156: error: ‘Scsi_Cmnd’ has no member named ‘data_cmnd’
make[2]: *** [drivers/scsi/NCR53C9x.o] Error 1

<--  snip  -->
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

