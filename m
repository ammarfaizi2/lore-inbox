Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSLGTPB>; Sat, 7 Dec 2002 14:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSLGTPB>; Sat, 7 Dec 2002 14:15:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9222 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264679AbSLGTPA>;
	Sat, 7 Dec 2002 14:15:00 -0500
Date: Sat, 7 Dec 2002 11:22:04 -0800
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Adam Belay <ambx1@neo.rr.com>, perex@suse.cz, linux-kernel@vger.kernel.org,
       pelaufer@adelphia.net
Subject: Re: [PATCH] Linux PnP Support V0.93 - 2.5.50
Message-ID: <20021207192203.GB16559@kroah.com>
References: <20021201143221.GC333@neo.rr.com> <Pine.LNX.4.50.0212071322230.3130-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212071322230.3130-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 01:24:29PM -0500, Zwane Mwaikambo wrote:
> On Sun, 1 Dec 2002, Adam Belay wrote:
> 
> > Attached is a patch, gzipped for size, that updates the 2.5.50 to the latest pnp
> > version.  It includes all 9 of the previously submitted patches.
> >
> > Highlights are as follows:
> > -PnP BIOS fixes
> > -Several new macros
> > -PnP Card Services
> > -Various bug fixes
> > -more drivers converted to the new APIs
> >
> > PnP developers please use this patch.
> 
> Could we get a void* in pnp_dev? I'm finding myself resorting to
> driver internal arrays in order to track locations of device private structures.

Use the struct device void pointer for stuff like this.  There's some
helpful functions to get access to this easily (but don't seem to see
them in pnp.h at first glance...)

thanks,

greg k-h
