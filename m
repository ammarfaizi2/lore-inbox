Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJWTmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJWTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:42:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41693 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261732AbTJWTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:42:19 -0400
Date: Thu, 23 Oct 2003 21:42:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Matt Domsch <Matt_Domsch@dell.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.23-pre8: link error with both megaraid drivers
Message-ID: <20031023194211.GG11807@fs.tum.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> <20031023140743.GF11807@fs.tum.de> <20031023141812.GC18370@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023141812.GC18370@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 03:18:12PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 23, 2003 at 04:07:43PM +0200, Adrian Bunk wrote:
> > --- linux-2.4.23-pre7-full/drivers/scsi/Config.in.old	2003-10-11 17:00:47.000000000 +0200
> > +++ linux-2.4.23-pre7-full/drivers/scsi/Config.in	2003-10-11 17:24:00.000000000 +0200
> > -dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
> > +if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
> > +  define_tristate CONFIG_SCSI_MEGARAID2_DEP $CONFIG_SCSI
> > +else
> > +  define_tristate CONFIG_SCSI_MEGARAID2_DEP m $CONFIG_SCSI
> > +fi
> > +dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI_MEGARAID2_DEP
> 
> define_tristate?!  Did you actually try this?

Yes, I tried it.

What exactly isn't working for you?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

