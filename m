Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUGNQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUGNQjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUGNQjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:39:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61888 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267449AbUGNQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:39:40 -0400
Date: Wed, 14 Jul 2004 18:39:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Genady Okrain <mafteah@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't compile sg.c 2.6.8-rc1-mm1
Message-ID: <20040714163933.GD7308@fs.tum.de>
References: <30a4d01b04071401457267defa@mail.gmail.com> <40F55763.4080600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F55763.4080600@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 11:55:15AM -0400, Jeff Garzik wrote:
> Genady Okrain wrote:
> >I am using gcc-3.4.1
> >
> >  CC [M]  drivers/scsi/sg.o
> >drivers/scsi/sg.c: In function `sg_ioctl':
> >drivers/scsi/sg.c:209: sorry, unimplemented: inlining failed in call
> >to 'sg_jif_to_ms': function body not available
> >drivers/scsi/sg.c:930: sorry, unimplemented: called from here
> >make[2]: *** [drivers/scsi/sg.o] Error 1
> >make[1]: *** [drivers/scsi] Error 2
> >make: *** [drivers] Error 2
> 
> 
> Looks like a compiler bug.

No, it's an inline that is used before it's defined.

I'll send a fix soon.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

