Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWC1XEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWC1XEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWC1XEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:04:09 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51597 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964794AbWC1XEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:04:08 -0500
Subject: Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <4428FEA5.9020808@yahoo.com.au>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	 <4428FB90.5000601@sw.ru>  <4428FEA5.9020808@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:04:18 +1200
Message-Id: <1143587058.6325.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 19:15 +1000, Nick Piggin wrote:
> Kirill Korotaev wrote:
> > First of all, what it does which low level virtualization can't:
> > - it allows to run 100 containers on 1GB RAM
> >   (it is called containers, VE - Virtual Environments,
> >    VPS - Virtual Private Servers).
> > - it has no much overhead (<1-2%), which is unavoidable with hardware
> >   virtualization. For example, Xen has >20% overhead on disk I/O.
> Are any future hardware solutions likely to improve these problems?

No, not all of them.

> > OS kernel virtualization
> > ~~~~~~~~~~~~~~~~~~~~~~~~
> Is this considered secure enough that multiple untrusted VEs are run
> on production systems?

Yes, hosting providers have been deploying this technology for years.

> What kind of users want this, who can't use alternatives like real
> VMs?

People who want low overhead and the administrative benefits of only
running a single kernel and not umpteen.  For instance visibility from
the host into the guests' filesystems is a huge advantage, even if the
performance benefits can be magically overcome somehow.

> > Summary of previous discussions on LKML
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Have their been any discussions between the groups pushing this
> virtualization, and important kernel developers who are not part of
> a virtualization effort? Ie. is there any consensus about the
> future of these patches?

Plenty recently.  Check for threads involving (the people on the CC list
to the head of this thread) this year.

Comparing Xen/VMI with Vserver/OpenVZ is comparing apples with orchards.
May I refer you to some slides for a talk I gave at Linux.conf.au about
Vserver: http://utsl.gen.nz/talks/vserver/slide17a.html

Sam.




