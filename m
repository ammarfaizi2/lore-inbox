Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUI2PpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUI2PpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUI2PpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:45:01 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:28392 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268663AbUI2Pos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:44:48 -0400
Date: Wed, 29 Sep 2004 17:44:37 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929154437.GD22008@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random> <20040929060521.GA6975@devserv.devel.redhat.com> <20040929141151.GJ4084@dualathlon.random> <1096467886.15905.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096467886.15905.33.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:24:46PM +0100, Alan Cox wrote:
> As the man page says
> 
> "Use of this option is discouraged."

and as a matter of fact the vast majority of mmaps executed by databases
with vlm are using MAP_FIXED ;)

I'm not saying databases themself are going to break with topdown, I'm just saying
there are applications out there making heavy use of MAP_FIXED, no
matter if the above manpage says it's discouraged. depending on
applications not to use it, isn't reliable and it's prone to break
randomly at runtime with topdown, this is my _only_ point, and it's a
tangible fact as far as I can tell (not a purerly theoretical issue like
the set_pte not being exceuted in asm).

If you want to make your kernel really safe, then disable MAP_FIXED and
return -EINVAL, then I agree it will be safe.
