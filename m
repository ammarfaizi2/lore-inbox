Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290811AbSBLHhz>; Tue, 12 Feb 2002 02:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290815AbSBLHhq>; Tue, 12 Feb 2002 02:37:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290811AbSBLHhf>;
	Tue, 12 Feb 2002 02:37:35 -0500
Message-ID: <3C68C63B.8A785890@mandrakesoft.com>
Date: Tue, 12 Feb 2002 02:37:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Pete Zaitcev <zaitcev@redhat.com>,
        Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk prefix cleanups.
In-Reply-To: <Pine.LNX.4.44.0202120923350.30276-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Tue, 12 Feb 2002, Pete Zaitcev wrote:
> 
> > > Here is a simple patch which reduces resultant binary size by 1.2k for
> > > this particular module (opl3sa2). [...]
> >
> > >  #define OPL3SA2_MODULE_NAME        "opl3sa2"
> > > +#define OPL3SA2_PFX                OPL3SA2_MODULE_NAME ": "
> >
> > > -                   printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
> > > +                   printk(KERN_ERR OPL3SA2_PFX "MSS mixer not installed?\n");
> >
> > I do not believe that it shortens binaries. Care to quote
> > size(1) output and /proc/modules with and without the patch?
> 
> It does _not_ reduce the memory footprint, that i knew before doing the
> patch, the only thing it does do is reduce the resultant binary's
> filesize. Surely thats worth it just for the space saving? size(1) reports
> the same sizes for both patched and unpatched.

If size(1) reports the same size, then no.

But I would still support a patch that added just 'PFX' to the driver...

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
