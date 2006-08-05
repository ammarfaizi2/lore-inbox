Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWHEAGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWHEAGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 20:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWHEAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 20:06:40 -0400
Received: from ozlabs.org ([203.10.76.45]:39298 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422652AbWHEAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 20:06:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17619.57607.638788.298986@cargo.ozlabs.ibm.com>
Date: Sat, 5 Aug 2006 10:06:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zachary Amsden <zach@vmware.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
In-Reply-To: <20060804143420.GB16313@thunk.org>
References: <44D1CC7D.4010600@vmware.com>
	<20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com>
	<20060803200136.GB28537@kroah.com>
	<44D26D87.2070208@vmware.com>
	<1154644383.23655.142.camel@localhost.localdomain>
	<44D2794A.0@vmware.com>
	<1154647835.23655.161.camel@localhost.localdomain>
	<44D28985.8050200@vmware.com>
	<1154686885.23655.198.camel@localhost.localdomain>
	<20060804143420.GB16313@thunk.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso writes:

> IBM's virtualization *does* have magic blobs; it's called the
> hypervisor.  The difference is that the PowerPC have a delibierately
> castrated architecture such that when you are running a guest
> operating system in an LPAR, so that when you do things like mess with
> page tables (for example), it traps to the hypervisor which is really

Well no.  When the kernel wants to change the hardware page tables it
doesn't even try to do it itself, it calls the hypervisor via the
"hypervisor system call" instruction.  It's entirely analogous to a
program calling the "write" system call to send output to a terminal
rather than trying to drive the serial port directly (via outb
instructions or whatever).

> "a magic binary blob" running on the bare Power architecture.  The

Not really.  Not any more than the Windows kernel is a "magic binary
blob" in a GPL'd program running under Windows.

> difference is that the way you trap into the hypervisor is via a
> PowerPC instructure that looks like a native instruction call.

Wow, you must have been really tired when you wrote that... :)

> The bottom line is that the line between magic binary blobs and
> whether or not they are legal or not is more of a grey line than we
> might want to admit. 

It's quite clear that (a) being in a separate address space (b) having
a defined, documented interface and (c) being used by multiple
different client OSes is pretty good evidence that something is an
independent work, not a derived work of the kernel, and therefore not
subject to the GPL.

Paul.
