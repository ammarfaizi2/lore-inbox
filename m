Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264997AbSJWNyF>; Wed, 23 Oct 2002 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265004AbSJWNyF>; Wed, 23 Oct 2002 09:54:05 -0400
Received: from max.fiasco.org.il ([192.117.122.39]:35596 "HELO
	latenight.fiasco.org.il") by vger.kernel.org with SMTP
	id <S264997AbSJWNyE>; Wed, 23 Oct 2002 09:54:04 -0400
Subject: Re: One for the Security Guru's
From: Gilad Ben-ossef <gilad@benyossef.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035380716.4323.50.camel@irongate.swansea.linux.org.uk>
References: <20021023130251.GF25422@rdlg.net> 
	<1035380716.4323.50.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 15:59:02 +0200
Message-Id: <1035381547.4182.65.camel@klendathu.telaviv.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 15:45, Alan Cox wrote:
> On Wed, 2002-10-23 at 14:02, Robert L. Harris wrote:
> >   The consultants aparantly told the company admins that kernel modules
> > were a massive security hole and extremely easy targets for root kits.
> > As a result every machine has a 100% monolithic kernel, some of them
> > ranging to 1.9Meg in filesize.  This of course provides some other
> > sticky points such as how to do a kernel boot image
> 
> Modules make no difference to security. If I can add a module I can swap
> the kernel and reboot the box, or I can patch the kernel. In fact I can
> load modules into module-less kernels its just a bit harder.

IMHO the security risks associated with modules is not the potential for
getting higher permissions but rather that having the loadable module
capability makes it *easier* to hide your code and actions once you're
in because what you would want to do is change the running kernel to
hide your actions and loadable modules makes it easier to dynamically
change a running kernel in general (DUH! :-). In short - LKM support
doesn't open any doors; It does makes it slightly easier to stay
invisible once you're in. 

There are, again IMHO, much simpler things that I'm willing to bet
company X isn't doing (because no one is doing them) that would help
much more to security then disabling LKM support. For example - when you
download a new update of a kernel (or any program for that matter)
source/patch (or binary package) from the net do you check the GPG
signature validity? I would be VERY surprised if you answer 'yes'...
:-))

Gilad.



> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


