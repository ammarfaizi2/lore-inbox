Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317660AbSGaCuW>; Tue, 30 Jul 2002 22:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSGaCuW>; Tue, 30 Jul 2002 22:50:22 -0400
Received: from khms.westfalen.de ([62.153.201.243]:26306 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317660AbSGaCtl>; Tue, 30 Jul 2002 22:49:41 -0400
Date: 31 Jul 2002 00:46:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: vojtech@suse.cz
cc: linux-kernel@vger.kernel.org
Message-ID: <8TuNa2cHw-B@khms.westfalen.de>
In-Reply-To: <20020730233907.B23181@ucw.cz>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20020730233907.B23181@ucw.cz>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vojtech@suse.cz (Vojtech Pavlik)  wrote on 30.07.02 in <20020730233907.B23181@ucw.cz>:

> On Wed, Jul 31, 2002 at 07:26:05AM +1000, Brad Hards wrote:
> > On Wed, 31 Jul 2002 07:09, Greg KH wrote:
> > > On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > > > -#include <asm/types.h>
> > > > +#include <stdint.h>
> > >
> > > Why?  I thought we were not including any glibc (or any other libc)
> > > header files when building the kernel?
> > Should be <linux/types.h>
>
> It's #ifndef __KERNEL__ and if we #include <linux/types.h> and the user
> #includes <stdint.h> elsewhere, we're going to get collisions.
>
> I guess __u16 is really the safe way here.

Well then, I guess the thing to do for the poor ignorant user space  
programmers is to have one standard header somewhere which maps the  
standard Linux kernel types to standard ISO C types. No?

MfG Kai
