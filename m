Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGNQya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGNQya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267458AbUGNQya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:54:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265044AbUGNQy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:54:26 -0400
Date: Wed, 14 Jul 2004 18:54:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040714165419.GF7308@fs.tum.de>
References: <200407141216.i6ECGHxg008332@harpo.it.uu.se> <40F556CE.9000707@pobox.com> <20040714164253.GE7308@fs.tum.de> <40F562FC.50806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F562FC.50806@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:44:44PM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >On Wed, Jul 14, 2004 at 11:52:46AM -0400, Jeff Garzik wrote:
> >
> >>...
> >>If gcc is insisting that prototypes for inlines no longer work, we have 
> >>a lot of code churn on our hands ;-(  Grumble.
> >
> >
> >I've counted at about 30 files with such problems in a full i386 
> >2.6.7-mm7 compile.
> >
> >I've already sent patches for some of them (e.g. the dmascc.c one), and 
> >they are usually pretty straightforward.
> 
> This is not a problem with the kernel.
> 
> All these files have been functioning just fine for years, with properly 
> prototyped static inline functions.

Add -Winline to the compile flags, and name one gcc version that is able 
to inline them all in sg.c ...

> Though there is a the claim that '#define inline always_inline' is 
> leading to all this breakage.

gcc 3.4 is just complaining louder that it can't inline something it was 
told to inline.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

