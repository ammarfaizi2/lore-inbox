Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLOUlj>; Fri, 15 Dec 2000 15:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLOUl3>; Fri, 15 Dec 2000 15:41:29 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:11272 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129383AbQLOUlX>; Fri, 15 Dec 2000 15:41:23 -0500
Date: Fri, 15 Dec 2000 15:15:03 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: root@chaos.analogic.com, Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Andrea Arcangeli <andrea@suse.de>, Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215151503.A24830@munchkin.spectacle-pond.org>
In-Reply-To: <root@chaos.analogic.com> <200012151906.eBFJ6ac28241@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200012151906.eBFJ6ac28241@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Fri, Dec 15, 2000 at 04:06:36PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 04:06:36PM -0300, Horst von Brand wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> said:
> 
> [...]
> 
> > 	Both examples allow an extern declaration inside a function scope
> > 	which is also contrary to any (even old) 'C' standards. 'extern'
> > 	is always file scope, there's no way to make it otherwise.
> 
> AFAIR (rather dimly... no K&R at hand here) if you have an extern
> declaration inside a block, it will be visible only within that block. The
> object itself certainly is file scope (or larger).

Old K&R allowed the following:

	foo(){
	  extern int a;

	  a = 1;
	}

	bar(){
	  a = 2;
	}

Ie, compiler put the definition for a in the file scope symbol table, and not
the current block's.  The above example is illegal in ISO C.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
