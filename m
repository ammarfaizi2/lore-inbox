Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVANMnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVANMnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVANMnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:43:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62610 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261973AbVANMmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:42:08 -0500
Message-Id: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Thu, 13 Jan 2005 09:33:38 -0800." <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 14 Jan 2005 09:39:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 14 Jan 2005 09:39:45 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:
> On Thu, 13 Jan 2005, Alan Cox wrote:
> > On Iau, 2005-01-13 at 16:38, Linus Torvalds wrote:

> > > It wouldn't be a global flag. It's a per-process flag. For example,
> > > many people _do_ need to execute binaries in their home directory. I
> > > do it all the time. I know what a compiler is.

> > noexec has never been worth anything because of scripts. Kernel won't
> > load that binary, I can write a script to do it.

> Scripts can only do what the interpreter does. And it's often a lot harder
> to get the interpreter to do certain things. For example, you simply
> _cannot_ get any thread race conditions with most scripts out there, nor 
> can you generally use magic mmap patterns.

But you can trivially run an executable via e.g.:

    /lib/ld-2.3.4.so some-nice-proggie

and the execute permissions (and noexec, etc) on some-nice-proggie don't
matter.

> Am I claiming that disallowing self-written ELF binaries gets rid of all 
> security holes? Obviously not.

It makes their running a bit harder, but not much.

>                                I'm claiming that there are things that 
> people can do that make it harder, and that _real_ security is not about 
> trusting one subsystem, but in making it hard enough in many independent 
> ways that it's just too effort-intensive to attack.

Right. But this is a broken idea, IMVHO.


Besides, something that has been overlooked in all this discussion so far:
It does routinely happen that fixing some "just an ordinary bug" really
does correct a security problem. Plus backporting "only security fixes"
gets harder and harder as they start depending on other random changes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
