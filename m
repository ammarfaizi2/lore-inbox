Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTABCte>; Wed, 1 Jan 2003 21:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbTABCtd>; Wed, 1 Jan 2003 21:49:33 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:55488 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265587AbTABCta>; Wed, 1 Jan 2003 21:49:30 -0500
Date: Thu, 2 Jan 2003 03:57:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Subject: Re: sparc32 net devices
Message-ID: <20030102025754.GJ17053@louise.pinerecords.com>
References: <20030101204954.GD17053@louise.pinerecords.com> <20030101155849.A20852@devserv.devel.redhat.com> <20030101215949.GG17053@louise.pinerecords.com> <20030101212215.B1006@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101212215.B1006@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [zaitcev@redhat.com]
> 
> > Date: Wed, 1 Jan 2003 22:59:49 +0100
> > From: Tomas Szepe <szepe@pinerecords.com>
> 
> > Here's a first stab then.  No need to include sbus devices
> > in drivers/net/Kconfig, they're all there already.  Unfortunately
> > this has to tune a lot of drivers' bus dependencies, I'm quite sure
> > I've missed some.
> 
> >  config NET_VENDOR_SMC
> >  	bool "Western Digital/SMC cards"
> > -	depends on NET_ETHERNET
> > +	depends on NET_ETHERNET && (ISA || MCA || EISA)
> >  	help
> >  	  If you have a network (Ethernet) card belonging to this class, say Y
> 
> Looks ok with me. If Dave or Jeff take it for common drivers/net/,
> I'm taking arch/sparc part. Thanks. I trust you tried at least to
> compile the result :)

Oh sure I did :)

Good.  I've got to hit the hay now, tomorrow I'll put the complete
diff together and split it according to what is to be sent to whom.

-- 
Tomas Szepe <szepe@pinerecords.com>
