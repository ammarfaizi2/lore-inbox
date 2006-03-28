Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWC1W0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWC1W0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWC1W0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:26:06 -0500
Received: from iron.cat.pdx.edu ([131.252.208.92]:6025 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S932458AbWC1W0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:26:04 -0500
Date: Tue, 28 Mar 2006 14:25:06 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603282225.k2SMP6kb023905@baham.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is just a question about intended meaning in a paragraph  
at the end of the "What are memory barriers?" section.

 > From: Paul E. McKenney Thu Mar 16 2006 - 18:14:11 EST 
 > On Wed, Mar 15, 2006 at 02:23:19PM +0000, David Howells wrote:
 > > 
 > > The attached patch documents the Linux kernel's memory barriers.
 > > 
 > > I've updated it from the comments I've been given.
 > > 
 > . . .
 > 
 > Good stuff!!! Please see comments interspersed, search for empty lines.
 > 
 > One particularly serious issue involve your smp_read_barrier_depends()
 > example.
 > 
 > > Signed-Off-By: David Howells <dhowells@redhat.com>
 > > ---
 > > warthog>diffstat -p1 /tmp/mb.diff 
 > > Documentation/memory-barriers.txt | 1039 
 > ++++++++++++++++++++++++++++++++++++++
 > > 1 files changed, 1039 insertions(+)
 > > 
 > > diff --git a/Documentation/memory-barriers.txt 
 > b/Documentation/memory-barriers.txt
 > > new file mode 100644
 > > index 0000000..fd7a6f1
 > > --- /dev/null
 > > +++ b/Documentation/memory-barriers.txt
 > > @@ -0,0 +1,1039 @@
 > > + ============================
 > > + LINUX KERNEL MEMORY BARRIERS
 > > + ============================
 
 . . .
 
 > > +=========================
 > > +WHAT ARE MEMORY BARRIERS?
 > > +=========================
 > > +
 
 > . . . 
 
 > > +It is also guaranteed that a CPU will be self-consistent: it will see its _own_
 > > +accesses appear to be correctly ordered, without the need for a memory barrier.
 > > +For instance with the following code:
 > > +
 > > + X = *A;
 > > + *A = Y;
 > > + Z = *A;
 > > +
 > > +assuming no intervention by an external influence, it can be taken that:
 > > +
 > > + (*) X will hold the old value of *A, and will never happen after the write and
 > > + thus end up being given the value that was assigned to *A from Y instead;
 
Seems like the subject of "will never happen" is the read from memory for the 
asmt to X, but does that sentence say that?  

 > > + and
 > > +
 > > + (*) Z will always be given the value in *A that was assigned there from Y, and
 > > + will never happen before the write, and thus end up with the same value
 > > + that was in *A initially.
 
Similarly, the read from memory for the asmt to Z won't precede the write of Y
to *A.
 
 > > +
 > > +(This is ignoring the fact that the value initially in *A may appear to be the
 > > +same as the value assigned to *A from Y).
 > > +
 > > +
 > > +=================================
 > > +WHERE ARE MEMORY BARRIERS NEEDED?
 > > +=================================

It seems to require more effort than necessary to understand in regard to
all that is presented in this document.

Thanks.
Suzanne
