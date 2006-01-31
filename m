Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWBAAQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWBAAQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBAAQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:16:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751246AbWBAAQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:16:43 -0500
Date: Tue, 31 Jan 2006 23:16:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Gabriel C." <crazy@pimpmylinux.org>, da.crew@gmx.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Message-ID: <20060131221637.GJ3986@stusta.de>
References: <20060130133833.7b7a3f8e@zwerg> <200601311416.05397.vda@ilport.com.ua> <20060131145431.GI5433@tuxdriver.com> <200601311658.09423.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601311658.09423.vda@ilport.com.ua>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 04:58:09PM +0200, Denis Vlasenko wrote:
> On Tuesday 31 January 2006 16:54, John W. Linville wrote:
> > On Tue, Jan 31, 2006 at 02:16:05PM +0200, Denis Vlasenko wrote:
> > 
> > > CONFIG_ACX=y
> > > # CONFIG_ACX_PCI is not set
> > > # CONFIG_ACX_USB is not set
> > > 
> > > This won't fly. You must select at least one.
> > > 
> > > Attached patch will check for this and #error out.
> > > Andrew, do not apply to -mm, I'll send you bigger update today.
> > 
> > Is there any way to move this into a Kconfig file?  That seems nicer
> > than having #ifdefs in source code to check for a configuration error.
> 
> Can't think of any at the moment.

There are two possible solutions ("offer" means "is user visible"):
- only offer ACX and always build ACX_PCI/ACX_USB depending on the
  availability of PCI/USB
- only offer ACX_PCI and ACX_USB which select ACX

If you tell me which you prefer I can send a patch.

> vda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

