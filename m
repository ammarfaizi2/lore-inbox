Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264713AbTIDGGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTIDGGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:06:09 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:13256 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264713AbTIDGGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:06:06 -0400
Date: Wed, 3 Sep 2003 23:33:46 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       Jamie Lokier <jamie@shareable.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.LNX.4.56.0309032200010.2146@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0309032332040.29966-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Davide Libenzi wrote:

> On Wed, 3 Sep 2003, Nagendra Singh Tomar wrote:
> 
> > Jamie,
> > 	Just wondered if the store buffer is snooped in some
> > architectures. In that case I believe the OS need not do anything for
> > serialization (except for aliases, if they do not hit the same cache
> line).
> > In x86 store buffer is not snooped which leads to all these
> serialization
> > issues (other CPUs looking at stale value of data which is in the
> store
> > buffer of some other CPU).
> > Pl correct me if I have got anything wrong/
> 
> To avoid the so called 'load hazard' (that, BTW, triggers read over
> writes, that are not allowed in x86) you have two options. Snoop the
> write
> buffer or flush it upon L1 miss. Otherwise you might end up getting
> stale
> data from L2.
> 

I meant to ask if the store buffer is snooped by *other CPUs*. To maintain 
self coherence the local store buffer has to be anyway consulted by local 
loads to give the latest stored value. 

Thanx,

tomar
> 
> 
> - Davide
> 

