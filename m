Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVFKKVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVFKKVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVFKKVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 06:21:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261675AbVFKKVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 06:21:43 -0400
Date: Sat, 11 Jun 2005 12:21:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050611102133.GA3770@stusta.de>
References: <20050611074327.GA27785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611074327.GA27785@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:43:27AM -0700, Greg KH wrote:
>...
> Comments welcome.
>...

Please don't remove the !CONFIG_DEVFS_FS dummies from devfs_fs_kernel.h.

I'm sure some driver maintainers will want to keep the functions in 
their code because they share their drivers between 2.4 and 2.6 .

Keeping a devfs_fs_kernel.h with dummy functions doesn't hurt, but it 
prevents version #ifdef's in drivers and/or the same dummy functions in 
some subsystem specific headers.

> thanks,
> 
> greg k-h
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

