Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVC2A4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVC2A4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 19:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVC2A4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 19:56:30 -0500
Received: from smtpout.mac.com ([17.250.248.97]:56060 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262131AbVC2A41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 19:56:27 -0500
In-Reply-To: <1112055671.3691.8.camel@localhost.localdomain>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl> <1112011441.27381.31.camel@localhost.localdomain> <1112016850.6003.13.camel@laptopd505.fenrus.org> <1112018265.27381.63.camel@localhost.localdomain> <20050328154338.753f27e3.pj@engr.sgi.com> <1112055671.3691.8.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com>
Content-Transfer-Encoding: 7bit
Cc: floam@sh.nu, LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org,
       vonbrand@inf.utfsm.cl, bunk@stusta.de
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Mon, 28 Mar 2005 19:56:09 -0500
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2005, at 19:21, Steven Rostedt wrote:
> So you are saying that a stand alone section of code, that needs
> wrappers to work with Linux is a derived work of Linux? If there's
> some functionality, that you make, and it just happens to need
> some kind of operating system to work. Does that make it a derived
> work of any operating system?

It depends on how special and different the wrappers for Linux are
from the wrappers for other operating systems.  Like, for example,
the sysfs stuff is so radically different from the APIs that other
operating systems provide that anything using it is most likely
copied from other in-kernel sysfs code, and is therefore derived
from the Linux kernel.

> OK, I took your advise and found this from googling:
>
> http://www.pbwt.com/Attorney/files/ravicher_1.pdf

Mmm, good reference, thanks!

> Unless you misunderstood me, and thought that I was talking
> about taking some part of Linux and making it work under another
> OS, I still stand by my statement.

I think it really depends on the APIs implemented.  Anything based
on the sysfs code, even if only using the APIs, will probably be
found to be a derivative work (NOTE: IANAL) because the sysfs API
is so very different from everything else.  Other interfaces like
PCI management, memory management, etc, may not be so protectable,
because they are standard across many systems.  If Linux got a
new and unique memory hotplug API, however, that might be a very
different story.  Similar things could be said about integration
between drivers and the new Unified Driver Model, which appears to
be quite original.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


