Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSAEUSC>; Sat, 5 Jan 2002 15:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282523AbSAEURx>; Sat, 5 Jan 2002 15:17:53 -0500
Received: from glisan.hevanet.com ([198.5.254.5]:65036 "EHLO
	glisan.hevanet.com") by vger.kernel.org with ESMTP
	id <S282511AbSAEURn>; Sat, 5 Jan 2002 15:17:43 -0500
Date: Sat, 5 Jan 2002 12:17:24 -0800 (PST)
From: jkl@miacid.net
To: Florian Weimer <fw@deneb.enyo.de>
cc: "Joseph S. Myers" <jsm28@cam.ac.uk>, dewar@gnat.com,
        Dautrevaux@microprocess.com, paulus@samba.org,
        Franz.Sirl-kernel@lauterbach.com, benh@kernel.crashing.org,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, minyard@acm.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87ofk88t4o.fsf@deneb.enyo.de>
Message-ID: <Pine.BSI.4.10.10201051208250.8542-100000@hevanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jan 2002, Florian Weimer wrote:

> jkl@miacid.net writes:
> 
> > An arbitrary integer may be converted to a pointer.  
> >    ^^^^^^^^^
> 
> This rule exists so that implementations are not forced to issue a
> diagnostic for (char *)1.
>
No.  If the only goal was to avoid a diagnostic, the it could be
undefined.  The fact that it is implementation defined means that it's
reasonable to expect it to be useful for something.
 
> > 	I interpret this to mean that one MAY use integer arithmatic to
> > do move a pointer outside the bounds of an array.  Specifically, as soon
> > as I've cast the pointer to an integer, the compiler has an obligation to
> > forget any assumptions it makes about that pointer.  This is what casts
> > from pointer to integer are for!  when i say (int)p I'm saying that I
> > understand the address structure of the machine and I want to manipulate
> > the address directly.
> 
> According to the standard, you say that you want to cast p to type
> int.  You cannot manipulate machine addresses in C because C is
> defined as a high-level language, without backdoors to such low-level
> concepts as machine addresses.
> 
> The fact that quite a few implementations traditionally provide
> such backdoors in some cases does not mean that the C language is a
> low-level language, or that all implementations (even future ones)
> have to provide these backdoors.
> 

Whether C is a "low-level" or "high-level" language (whatever that
means) is not the issue here.  The issue here is that, as you say, quite a
few implementations of C provide the ability to access arbitrary memory
through pointers, and the standard provides some convenient places for the
implementation to do it, and many users of GCC would really like to have
this feature.

Forgive me if I haven't been reading the manual carefully enough.  Now can
we please get a straight answer to the question:  Does GCC provide the
ability to turn an arbitrary address into a pointer, and if so how do you
do it?

-JKL


