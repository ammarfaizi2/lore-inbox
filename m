Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVJDPrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVJDPrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVJDPrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:47:06 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:54495 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964820AbVJDPrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:47:04 -0400
Date: Tue, 4 Oct 2005 09:46:55 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Ryan Anderson <ryan@autoweb.net>,
       Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>, andrew.patterson@hp.com,
       Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20051004154655.GE20557@parisc-linux.org>
References: <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com> <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org> <434293D8.50300@adaptec.com> <43429789.8020102@pobox.com> <43429D6C.8070909@adaptec.com> <43429F1B.1000002@pobox.com> <4342A261.1040808@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4342A261.1040808@adaptec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 11:40:17AM -0400, Luben Tuikov wrote:
> On 10/04/05 11:26, Jeff Garzik wrote:
> > You continue to misunderstand everyone else's opinion.
> 
> Internet mailing lists are one such thing where anyone
> can write anything they want and sound smart.  Like
> the statement above.
> 
> Did you talk to "everyone else"?  Or is this just you,
> James B and Christoph?

It's mine too, but I hadn't seen the need to perpetuate this stupid
thread.

> "should", "will".
> 
> The question is then: Where were you Jeff all this time?

Working on other things?  It's not like scsi core is the only armpit
the kernel has.

> Why did the SAS code had to be posted for SCSI Core to see how many
> things it needs to repair.
> 
> I've been pointing those things out since, oh well, for many years
> now.

But people have been working on improving scsi core for many years.  The
transport classes have a copyright daate of 2003 on them, for example.

> If SCSI Core had seen the necessary over the years changes,
> it wouldn't be in this situation now.

Things take time.  Even standards committees.

> > Nothing is upside down.  Transport details plug into an obvious location 
> > -- the transport class, and associated helper libs (if any).
> 
> USB/SAS/SBP:
> HW -> LLDD -> Transport Layer -> SCSI Core
> 
> MPT:
> HW -> Transport Layer (FW) -> LLDD -> SCSI Core.

That's why we still need each driver to have a scsi host template.  That
way each driver can do what it needs to do.  For MPT, that's mostly 'ask
firmware and present the results to sas'.  For other SAS drivers, that's
probably 'call this function in the SAS trransport class that does
everything you want'.

If you like, you can think of it as working around a bug.  Instead of
doing it in the SAS class, we let the driver fix the layering bug.
