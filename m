Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKJQ5y>; Sun, 10 Nov 2002 11:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbSKJQ5y>; Sun, 10 Nov 2002 11:57:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14153 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264956AbSKJQ5x>; Sun, 10 Nov 2002 11:57:53 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
	<m1of8ycihs.fsf@frodo.biederman.org>
	<1036894347.22173.6.camel@irongate.swansea.linux.org.uk>
	<m1k7jmcgo5.fsf@frodo.biederman.org>
	<1036938641.1005.2.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Nov 2002 09:56:53 -0700
In-Reply-To: <1036938641.1005.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1n0ohbbxm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2002-11-10 at 02:16, Eric W. Biederman wrote:
> > To use kmapped memory I need to setup a page table to do the final copy.
> > And to setup a page table I need to know where the memory is going to be
> copied
> 
> > to.
> 
> And ?
> 
> I find it hard to believe you can't drive an MMU if you can write code
> that boots one Linux from another

One of the simplifying things I do between OS's is turn of the MMU, or
at least give it a 1-1 trivial mapping with physical memory.

If all of that memory is hanging out there forever. It probably makes sense
to be high memory capable.  But for the first rev of this I won't be.
Addresses > 4GB are a major pain to work with on x86.  

But I do have a test machine that can reproduce that so I can test for
strange bugs.  I added a BIOS option to put all but 512M out of 4GB
above the 4GB line.

Eric
