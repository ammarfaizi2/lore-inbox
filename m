Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVAMUHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVAMUHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVAMUDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:03:03 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10981 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261496AbVAMT7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:59:50 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105632757.4624.59.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105642416.5193.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 18:53:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 17:33, Linus Torvalds wrote:
> Scripts can only do what the interpreter does. And it's often a lot harder
> to get the interpreter to do certain things. For example, you simply
> _cannot_ get any thread race conditions with most scripts out there, nor 
> can you generally use magic mmap patterns.

And then perl was invented.

> Am I claiming that disallowing self-written ELF binaries gets rid of all 
> security holes? Obviously not. I'm claiming that there are things that 
> people can do that make it harder, and that _real_ security is not about 
> trusting one subsystem, but in making it hard enough in many independent 
> ways that it's just too effort-intensive to attack.

It lasts until someone publishes the first perl ELF loader/executor on
bugtraq, or ruby, or python, or java. Then everyone has it.

> It's the same thing with passwords. Clearly any password protected system
> can be broken into: you just have to guess the password. It then becomes a
> matter of how hard it is to "guess" - at some point you say a password is
> secure not because it is a password, but because it's too _expensive_ to
> guess/break.

Its more like breaking a password algorithm or everyone having the same
password unfortunately. One perl ELF loader, game over. You can do this
stuff with SELinux but even then it is very hard and you have to whack
the interpreters.

