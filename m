Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVA3XLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVA3XLD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVA3XLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:11:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31237 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261827AbVA3XK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:10:56 -0500
Date: Mon, 31 Jan 2005 00:10:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130231055.GA7103@stusta.de>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org> <20050130105738.GA28387@infradead.org> <20050130120009.GG3185@stusta.de> <20050130121241.GH3185@stusta.de> <Pine.LNX.4.61.0501302358270.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501302358270.6118@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 12:00:05AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 30 Jan 2005, Adrian Bunk wrote:
> 
> >  
> > +config WANT_EXPORTFS
> > +	tristate
> > +	select EXPORTFS
> > +
> >  config EXPORTFS
> >  	tristate
> > -	default NFSD
> >  
> 
> What's the difference between these two?

WANT_EXPORTFS gets selected by NFSD.

EXPORTFS is usually WANT_EXPORTFS, but if WANT_EXPORTFS=m and 
XFS_WANT_EXPORT=y, then EXPORTFS=y.

Since XFS_WANT_EXPORT itself depends on WANT_EXPORTFS this was my 
workaround to avoid a circular dependency.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

