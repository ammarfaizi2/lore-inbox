Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287070AbRL2B6T>; Fri, 28 Dec 2001 20:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287073AbRL2B6K>; Fri, 28 Dec 2001 20:58:10 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:27152 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287070AbRL2B6E>;
	Fri, 28 Dec 2001 20:58:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        garzik@havoc.gtf.org (Legacy Fishtank), linux-kernel@vger.kernel.org,
        lm@bitmover.com (Larry McVoy), esr@thyrsus.com (Eric S. Raymond),
        davej@suse.de (Dave Jones), marcelo@conectiva.com.br (Marcelo Tosatti),
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Sat, 29 Dec 2001 01:53:17 -0000."
             <E16K8gY-0002fQ-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 12:57:47 +1100
Message-ID: <8178.1009591067@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001 01:53:17 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> dependency problem, any solution that does not fix _all_ 9 problems in
>> http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2,
>> makefile-2.5_make_dep.html is not a complete fix.
>
>All well and good but "takes 100% longer" is number 10 on that list which
>you missed off, and the same argument holds for that.

You are missing the point Alan.

* The makefile rules are correct now.
* The build is correct now.
* kbuild 2.5 is faster on small compiles and much faster on recompiles
  after small changes.
* kbuild 2.5 is slower on large compiles.
* The speed problem is fixable, given time.  Correctness came first.
* I don't have time to keep tracking multiple kernels and architectures
  _and_ rewrite the core code.
* Once kbuild 2.5 is in the kernel I can spend far less time on
  tracking changes and can redesign the core programs for speed.
* It will get faster!

Why do you expect a change in a development kernel to be perfect first
time?  Look at all the bio changes, I just did a full 2.5.1 build and
had to disable 87 config options before the kernel would build, and
that is ignoring all the warning messages which point to out of date
function definitions.  Is anybody complaining that bio should have
worked first time?

Unlike bio, kbuild 2.5 works, it just needs to be a bit faster.  Put
kbuild 2.5 in the kernel and I will have a faster version within 2
weeks.

