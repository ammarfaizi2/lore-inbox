Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTACXaI>; Fri, 3 Jan 2003 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267715AbTACXaI>; Fri, 3 Jan 2003 18:30:08 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:25288 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267714AbTACXaH>; Fri, 3 Jan 2003 18:30:07 -0500
Date: Sat, 4 Jan 2003 00:38:36 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [unify netdev config 19/22] net.1-sparc
Message-ID: <20030103233836.GH1360@louise.pinerecords.com>
References: <3E14B164.mailLYS1115SL@louise.pinerecords.com> <200301032119.WAA23832@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301032119.WAA23832@post.webmailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
> > --- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
> > +++ b/drivers/net/Kconfig	2003-01-02 22:01:16.000000000 +0100
> > @@ -384,7 +384,7 @@
> >  
> >  config NET_VENDOR_3COM
> >  	bool "3COM cards"
> > -	depends on NET_ETHERNET
> > +	depends on NET_ETHERNET && (ISA || EISA || MCA || PCI)
> >  	help
> >  	  If you have a network (Ethernet) card belonging to this class, say Y
> >  	  and read the Ethernet-HOWTO, available from
> ... and a lot more.
> 
> There are some bus dependencies for network drivers that you omitted,
> either on purpose or by accident. The patch below adds these
> dependencies, which is required for compiling with allyesconfig
> on s390 and perhaps other architectures.
> The dependencies are taken either from reading the source of
> searching the web, so there is a chance that there are mistakes.

Splendid.  Thanks a lot!

-- 
Tomas Szepe <szepe@pinerecords.com>
