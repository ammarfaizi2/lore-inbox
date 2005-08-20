Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932783AbVHTTCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbVHTTCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbVHTTCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:02:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15627 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932783AbVHTTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:02:44 -0400
Date: Sat, 20 Aug 2005 21:02:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] adapt scripts/ver_linux to new util-linux version strings
Message-ID: <20050820190242.GY3615@stusta.de>
References: <20050820035853.GM3615@stusta.de> <20050820055532.GA15577@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820055532.GA15577@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 09:55:32AM +0400, Alexey Dobriyan wrote:
> On Sat, Aug 20, 2005 at 05:58:53AM +0200, Adrian Bunk wrote:
> > --- linux-2.6.13-rc6-mm1-full/scripts/ver_linux.old
> > +++ linux-2.6.13-rc6-mm1-full/scripts/ver_linux
> 
> > -fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
> > +fdformat --version | awk '{print "util-linux            ", $NF}' \
> > +| awk -F\) '{print $1}'
> >  
> > -mount --version | awk -F\- '{print "mount                 ", $NF}'
> > +mount --version | awk '{print "mount                 ", $NF}' | \
> > +awk -F\) '{print $1}'
> 
> -util-linux             2.12i
> -mount                  2.12i
> +util-linux             util-linux-2.12i
> +mount                  mount-2.12i
> 			^^^^^^
> 
> Is this intentional?

After this patch, the new format is parsed correctly instead of 
completely wrong.

You've found the small regression parsing the old format.

IMHO this is not a problem. If you disagree, feel free to send a better 
patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

