Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUHGRZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUHGRZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUHGRZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:25:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55031 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263784AbUHGRZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:25:31 -0400
Date: Sat, 7 Aug 2004 19:25:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040807172518.GA25169@fs.tum.de>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807181051.A19250@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 06:10:51PM +0100, Christoph Hellwig wrote:
> On Sat, Aug 07, 2004 at 07:01:22PM +0200, Adrian Bunk wrote:
> > The following architetures have their own "config PCMCIA" instead of 
> > including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
> > - m68k
> > - s390
> > - sparc
> > - sparc64
> > 
> > Is there any good reason for this, or would a patch to change these 
> > architectures to include drivers/pcmcia/Kconfig be OK?
> 
> What about switching them to use drivers/Kconfig instead?

drivers/Kconfig doesn't source drivers/pcmcia/Kconfig (and m68k 
already uses drivers/Kconfig).


But after a second look, I begin to understand a bit more:
Most of the architectures in question even have help text for the PCMCIA 
option, but the option itself isn't asked.

IOW: It's impossible to enable them.

Is there eny reason for such options that are never visible nor enabled, 
or could they be removed?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

