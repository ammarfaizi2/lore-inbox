Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbSJBLWg>; Wed, 2 Oct 2002 07:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263052AbSJBLWg>; Wed, 2 Oct 2002 07:22:36 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:49908 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263051AbSJBLWf>; Wed, 2 Oct 2002 07:22:35 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021002103932.C35A21EA74@alan.localdomain> 
References: <20021002103932.C35A21EA74@alan.localdomain> 
To: Alessandro Amici <alexamici@tiscali.it>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: 2.5.37+ i386 arch split broke external module builds 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 12:28:03 +0100
Message-ID: <4631.1033558083@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alexamici@tiscali.it said:
>  in order to access the kernel interfaces, modules that live outside
> the kernel sources were used to only need: CFLAG += -I$(TOPDIR)/
> include 

That was broken anyway -- you always got the CFLAGS wrong if you just did 
that. The only way that I only of to get the CFLAGS to match the kernel 
build reliably is to do something like:

 make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules

--
dwmw2


