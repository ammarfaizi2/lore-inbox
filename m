Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130639AbQK3RS2>; Thu, 30 Nov 2000 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129572AbQK3RSS>; Thu, 30 Nov 2000 12:18:18 -0500
Received: from 13dyn240.delft.casema.net ([212.64.76.240]:12037 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129982AbQK3RSJ>; Thu, 30 Nov 2000 12:18:09 -0500
Message-Id: <200011301647.RAA03831@cave.bitwizard.nl>
Subject: Re: [PATCH] New user space serial port driver
In-Reply-To: <200011301500.eAUF0o905978@flint.arm.linux.org.uk> from Russell
 King at "Nov 30, 2000 03:00:50 pm"
To: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 30 Nov 2000 17:47:24 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Tigran Aivazian <tigran@veritas.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Rogier Wolff writes:
> > > > +static struct termios    * ussp_termios[USSP_MAX_PORTS];
> > > > +static struct termios    * ussp_termios_locked[USSP_MAX_PORTS];
> > 
> > this SHOULD mean that these are first initialized before use. 
> > 
> > If you think they can be used before first being initialized by the
> > code, then that's a bug, and I'll look into it.
> 
> Ah, but they are initialised before use, by arch/*/kernel/head.S.
> Therefore no bug exists.

Documentation bug. Not code bug. 

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
