Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268793AbTBZPy6>; Wed, 26 Feb 2003 10:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268786AbTBZPy6>; Wed, 26 Feb 2003 10:54:58 -0500
Received: from daimi.au.dk ([130.225.16.1]:27068 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268793AbTBZPyH>;
	Wed, 26 Feb 2003 10:54:07 -0500
Message-ID: <3E5CE580.5ABA105E@daimi.au.dk>
Date: Wed, 26 Feb 2003 17:04:16 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic in i810
References: <3E595ED3.5D86FE45@daimi.au.dk> <3E5CB684.5A26BCA6@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> Kasper Dupont wrote:
> >
> > I have a reproducable kernel panic with different 2.4.x kernels.
> > I'm using XFree86-4.2.0-8 with a i810 onboard chipset. Sometimes
> > when I log off X the kernel panics. This can be reproduced by
> > loging in on a VC as root and typing:
> >
> > while [ ! -f /tmp/stopit ] ; do
> > killall gdmlogin || killall gdm ; sleep 7 ; deallocvt
> > done
> 
> I made a patch, that at least prevents the system from panicing.

I said that too early. It did survive my stress testing. But shortly
thereafter on logout I got an endless stream of NULL pointer errors
from the i810_dma_service IRQ handler.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
