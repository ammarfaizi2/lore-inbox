Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUFFMQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUFFMQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUFFMQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:16:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5071 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263370AbUFFMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:15:54 -0400
Date: Sun, 6 Jun 2004 14:15:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric BEGOT <eric_begot@yahoo.fr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre5
Message-ID: <20040606121545.GB5830@fs.tum.de>
References: <20040603022432.GA6039@logos.cnet> <40C08A0D.9010003@yahoo.fr> <20040604225247.GH7744@fs.tum.de> <40C19EDE.10405@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C19EDE.10405@yahoo.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Fri, Jun 04, 2004 at 04:41:17PM +0200, Eric BEGOT wrote:
> > 
> >
> >>when compiling linux-2.4.27-pre5 under a x86 architecture, I've a lot of 
> >>warnings :
> >>
> >>In file included from 
> >>/usr/src/devel//usr/src/devel/include/linux/modules/i386_ksyms.ver:127:1: 
> >>warning: "__ver_atomic_dec_and_lock" redefined
> >>In file included from /usr/src/devel/include/linux/modversions.h:70,
> >>              from <command line>:8:
> >>/usr/src/devel/include/linux/modules/dec_and_lock.ver:1:1: warning: this 
> >>is the location of the previous definition
> >>
> >>__ver_atomic_dec_and_lock is declared two times. Maybe it lacks a #ifdef 
> >>somewhere in the modversions.h no ?
> >>The compilation doesn't fail bu it's not very nice :)


I can't reproduce your problem with your .config .

Did you do something like patching the kernel or changing the SMP option
without running "make oldconfig" afterwards?

What are the values of __ver_atomic_dec_and_lock at the two places
mentiones in the warnings?

Does a
  cp .config /tmp
  make mrproper
  mv /tmp/.config
  make oldconfig
  make bzImage
fix this problem?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

