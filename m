Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288938AbSAETji>; Sat, 5 Jan 2002 14:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288940AbSAETj1>; Sat, 5 Jan 2002 14:39:27 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:51595 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288938AbSAETjI>; Sat, 5 Jan 2002 14:39:08 -0500
Date: Sat, 5 Jan 2002 19:37:48 +0000 (GMT)
From: "Joseph S. Myers" <jsm28@cam.ac.uk>
X-X-Sender: <jsm28@kern.srcf.societies.cam.ac.uk>
To: <jkl@miacid.net>
cc: Florian Weimer <fw@deneb.enyo.de>, <dewar@gnat.com>,
        <Dautrevaux@microprocess.com>, <paulus@samba.org>,
        <Franz.Sirl-kernel@lauterbach.com>, <benh@kernel.crashing.org>,
        <gcc@gcc.gnu.org>, <jtv@xs4all.nl>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.linuxppc.org>, <minyard@acm.org>, <rth@redhat.com>,
        <trini@kernel.crashing.org>, <velco@fadata.bg>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <Pine.BSI.4.10.10201051111100.8542-100000@hevanet.com>
Message-ID: <Pine.LNX.4.33.0201051929080.485-100000@kern.srcf.societies.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 jkl@miacid.net wrote:

> Wat this last bit added to the standard after ANSI/ISO 9899-1990?  I'm
> looking through my copy and I can't find it.  All I can find is that 

I was quoting from the GCC manual (providing the documentation
implementations are required to provide of implementation-defined
behaviour); of course the subclause numbers are different in C99 (from
which the subclause numbers in the GCC manual are given) from those in
C90.  Perhaps once all the documentation for implementation-defined
behaviour in C99 is present I'll go over what's required to document it
all relative to C90 as well.

> 	I interpret this to mean that one MAY use integer arithmatic to
> do move a pointer outside the bounds of an array.  Specifically, as soon
> as I've cast the pointer to an integer, the compiler has an obligation to
> forget any assumptions it makes about that pointer.  This is what casts
> from pointer to integer are for!  when i say (int)p I'm saying that I
> understand the address structure of the machine and I want to manipulate
> the address directly.

Just because you've created a pointer P, and it compares bitwise equal to
a valid pointer Q you can use to access an object, does not mean that P
can be used to access that object.  Look at DR#260, discussing the
provenance of pointer values, which arose from extensive discussion in the
UK C Panel, and if you think it should be resolved otherwise from how we
(UK C Panel) proposed then raise your position on it at a meeting of your
National Body before the next WG14 meeting.

http://std.dkuug.dk/JTC1/SC22/WG14/www/docs/dr_260.htm

-- 
Joseph S. Myers
jsm28@cam.ac.uk

