Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144924AbRA2CUN>; Sun, 28 Jan 2001 21:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144939AbRA2CUD>; Sun, 28 Jan 2001 21:20:03 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:7433 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S144924AbRA2CT5>;
	Sun, 28 Jan 2001 21:19:57 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101290219.f0T2JCF439854@saturn.cs.uml.edu>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
To: drepper@cygnus.com
Date: Sun, 28 Jan 2001 21:19:12 -0500 (EST)
Cc: pierre.rousselet@wanadoo.fr (Pierre Rousselet),
        david@linux.com (David Ford), devfs@oss.sgi.com, rgooch@atnf.csiro.au,
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <m3wvbgnnk3.fsf@otr.mynet.cygnus.com> from "Ulrich Drepper" at Jan 27, 2001 11:27:56 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper writes:
> Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:
>
>> for me :
>> make CFLAGS='-O2 -I. -D_GNU_SOURCE' 
>> compiles without any patch. is it correct ?
>
> Yes.  RTLD_NEXT is not in any standard, it's an extension available
> via -D_GNU_SOURCE.

This isn't a HURD feature.
This isn't even a C library feature.
This is a Linux feature.

So the _GNU_SOURCE thing is just plain wrong. Quit trying to
rename the OS.

Since there are so many standards to choose from, putting all features
into the default would be most obvious. Else what, pure C89 maybe?
Dang new-fangled standards might break something. Normal UNIX systems
don't make developers jump through hoops to get access to stuff; they
instead provide clean namespaces upon request.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
