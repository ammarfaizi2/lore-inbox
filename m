Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUGNTGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUGNTGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUGNTGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:06:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54775 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265175AbUGNTFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:05:52 -0400
Date: Wed, 14 Jul 2004 21:05:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjanv@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org, dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040714190542.GJ7308@fs.tum.de>
References: <200407141751.i6EHprhf009045@harpo.it.uu.se> <40F57D14.9030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F57D14.9030005@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:36:04PM -0400, Jeff Garzik wrote:
> Mikael Pettersson wrote:
> >It's needed, and no it's not a compiler bug.
> 
> In fact, it is.  gcc isn't properly inlining functions where uses occur 
> before implementation of the inlined function.
> 
> Or you could just call it "gcc is dumb" rather than a compiler bug.

gcc 3.4 seems to be the first gcc version that could actually handle 
such cases.

But since the kernel uses -fno-unit-at-a-time, it doesn't work.

The problem with unit-at-a-time is that it might increase the stack 
usage. Arjan explained this in the "GCC 3.4 and broken inlining." thread 
that started Thursday.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

