Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRKAPW7>; Thu, 1 Nov 2001 10:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279097AbRKAPWt>; Thu, 1 Nov 2001 10:22:49 -0500
Received: from mta.sara.nl ([145.100.16.144]:919 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S279113AbRKAPWd>;
	Thu, 1 Nov 2001 10:22:33 -0500
Message-Id: <200111011522.QAA22531@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: Mark Clayton <mark@brown-pelican.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unnumbered interfaces? 
In-Reply-To: Message from Mark Clayton <mark@brown-pelican.com> 
   of "Tue, 23 Oct 2001 19:55:11 EDT." <200110232355.TAA07996@smtp10.atl.mindspring.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Nov 2001 16:22:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm trying to understand unnumbered interfaces.  From 
> searching the web, they seem to be point-to-point links 
> that do not have IP numbers (hence the name).  This is
> what alludes:
> 
>  1) How do you set a pair on linux boxes to do this? ppp? 
>  2) How would a program send data across the link?  Via
> sockets?  Or thru /dev/something0?
>  3) Does it make sense that to use ethernet?  Not to me
> but sometimes I'm wrong :)
> 
> I'm sure I'm missing the obvious.  I usually do.  Can
> anyone shed some light on this topic?
> 
> Thanks,
> Mark
> --
> Mark & Kathy Clayton
> S/V Brown Pelican
> http://www.brown-pelican.com/  
> 
> 
Hi,

AFAIK, unnumbered interfaces are used only on routers on serial links and 
things like pos. Basically one would then enter a route entry routing one or 
more ip-blocks via an interface, not via the ip of a neigbouring router, in 
stead of the ip address of the neigbouring router one enters the name of the 
interface to use for this route.

Since these interfaces have no ip address, they cannot be the source of ip 
packets. Applications that generate ip traffic on such a router will use a 
different ip address on that router a the source ip, even if the packet has to 
go out on an unnumbered interface.

Having said this, unnumbered interfaces are quite rare in ip networks, most 
backbones use ip addresses on all of the interfaces of their routers. (do a 
traceroute to anywhere, you'll find very few hops that show no ip address).


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


