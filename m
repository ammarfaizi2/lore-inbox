Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbRE2We3>; Tue, 29 May 2001 18:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbRE2WeS>; Tue, 29 May 2001 18:34:18 -0400
Received: from u-155-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.155]:32239
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S262238AbRE2WeI>; Tue, 29 May 2001 18:34:08 -0400
Date: Wed, 30 May 2001 00:30:01 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Philip Blundell <philb@gnu.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Abramo Bagnara <abramo@alsa-project.org>,
        linux@arm.linux.org.uk, davem@caip.rutgers.edu, anton@linuxcare.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
Message-ID: <20010530003001.A2864@bacchus.dhis.org>
In-Reply-To: <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de> <bunk@fs.tum.de> <E1548jY-0004D2-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1548jY-0004D2-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Sun, May 27, 2001 at 11:10:00PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 11:10:00PM +0100, Philip Blundell wrote:

> >--- include/asm-arm/atomic.h.old	Sun May 27 22:30:58 2001
> >+++ include/asm-arm/atomic.h	Sun May 27 22:58:20 2001
> >@@ -12,6 +12,7 @@
> >  *   13-04-1997	RMK	Made functions atomic!
> >  *   07-12-1997	RMK	Upgraded for v2.1.
> >  *   26-08-1998	PJB	Added #ifdef __KERNEL__
> >+ *   27-05-2001	APB     Removed #ifdef __KERNEL__
> >  */
> > #ifndef __ASM_ARM_ATOMIC_H
> > #define __ASM_ARM_ATOMIC_H
> >@@ -30,7 +31,6 @@
> 
> This is no good.  The ARM kernel just doesn't provide any atomic primitives 
> that will work in user space.  If you want atomicity you have to use 
> libpthread.

Similar on some MIPS processors where the kernel has to implement atomic
operations because there is no practical possibility to implement them
in userspace.

  Ralf
