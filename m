Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTARJ3C>; Sat, 18 Jan 2003 04:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTARJ3C>; Sat, 18 Jan 2003 04:29:02 -0500
Received: from pop.gmx.de ([213.165.65.60]:15283 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263794AbTARJ3B>;
	Sat, 18 Jan 2003 04:29:01 -0500
Message-Id: <5.1.1.6.2.20030118103233.00cb4ff0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 18 Jan 2003 10:34:41 +0100
To: Sam Ravnborg <sam@ravnborg.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Cc: Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20030118092331.GA1483@mars.ravnborg.org>
References: <5.1.1.6.2.20030118085515.00c99e40@pop.gmx.net>
 <15911.64825.624251.707026@harpo.it.uu.se>
 <5.1.1.6.2.20030118085515.00c99e40@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:23 AM 1/18/2003 +0100, Sam Ravnborg wrote:
>On Sat, Jan 18, 2003 at 09:00:51AM +0100, Mike Galbraith wrote:
> > At 01:55 PM 1/17/2003 +0100, Mikael Pettersson wrote:
> >
> > >Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> > >problem and modules now load correctly for me.
> >
> > Hi,
> >
> > Putting . = ALIGN(64) back in front of __start___ksymtab = .
> > (vmlinux.lds.h) fixed it here.
>
>But that is just a way to hide the real problem.

Yup.  I was only checking to see if that change was why it was 
croaking.  Kai's patch works a treat here.

         -Mike

