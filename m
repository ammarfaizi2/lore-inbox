Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTIDGnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbTIDGnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:43:45 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:36482 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264732AbTIDGno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:43:44 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Sep 2003 23:38:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
cc: Jamie Lokier <jamie@shareable.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.LNX.4.44.0309032332040.29966-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0309032304490.916@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0309032332040.29966-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Nagendra Singh Tomar wrote:

> I meant to ask if the store buffer is snooped by *other CPUs*. To maintain
> self coherence the local store buffer has to be anyway consulted by local
> loads to give the latest stored value.

There are CPUs (at least some version of Alpha, 21064 IIRC) that uses
flush upon L1 read miss, so they do not snoop their local WB. IIRC P5 has
internal and external snooping while P6, using a write allocate L1, does
not have external snooping.



- Davide

