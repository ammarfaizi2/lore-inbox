Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbTALHZW>; Sun, 12 Jan 2003 02:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTALHZW>; Sun, 12 Jan 2003 02:25:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58315 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268253AbTALHZV>; Sun, 12 Jan 2003 02:25:21 -0500
Date: Sun, 12 Jan 2003 08:34:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: two more oddities with the fs/Kconfig file
Message-ID: <20030112073406.GM21826@fs.tum.de>
References: <Pine.LNX.4.44.0301120139010.21998-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301120139010.21998-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 02:07:13AM -0500, Robert P. J. Day wrote:
> 
>   there are a few options that are categorized as simply
> "bool", with no following label -- examples being UMSDOS,
> QUOTACTL, and a couple of others.  without a label on that
> line, the option is not displayed for selection anywhere
> on the menu.  is this deliberate?
>...

Yes, this is what was called define_bool in the old kconfig.

E.g.

config QUOTACTL
        bool
        depends on XFS_QUOTA || QUOTA
        default y

says that QUOTACTL is automatically selected if XFS_QUOTA or QUOTA is 
selected. This is a config option that is never visible to the user 
configuring the kernel.

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

