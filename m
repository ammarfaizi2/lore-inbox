Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbSJBVBy>; Wed, 2 Oct 2002 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJBVBy>; Wed, 2 Oct 2002 17:01:54 -0400
Received: from mail-6.tiscali.it ([195.130.225.152]:56884 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262583AbSJBVBx>;
	Wed, 2 Oct 2002 17:01:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alessandro Amici <alexamici@tiscali.it>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.5.37+ i386 arch split broke external module builds
Date: Wed, 2 Oct 2002 23:06:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
References: <20021002103932.C35A21EA74@alan.localdomain> <4631.1033558083@passion.cambridge.redhat.com>
In-Reply-To: <4631.1033558083@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021002210609.575031EA74@alan.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 13:28, David Woodhouse wrote:
> alexamici@tiscali.it said:
> >  in order to access the kernel interfaces, modules that live outside
> > the kernel sources were used to only need: CFLAG += -I$(TOPDIR)/
> > include
>
> That was broken anyway -- you always got the CFLAGS wrong if you just did
> that. The only way that I only of to get the CFLAGS to match the kernel
> build reliably is to do something like:
>
>  make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules

that one is the hacker way, the most powerfull and most correct for sure :)

however the average user of an external device driver (in the specific case 
i'm interested in distributing the rivatv driver found at 
http://rivatv.sf.net) is not going to have the source tree where the stock 
kernel he is running was built.

average users may have either a kernel-headers package that matches their 
running kernel and/or a souce package without the configuration stuff. in 
both cases 'the hacker way' doesn't work :)

OTOH, for small device drivers you don't need the full blown kernel CFLAGS, 
you know what you need anyway.

this is a user-, distribution-friendlyness issue :), we actually hit it in 
real life.

cheers,
alessandro
