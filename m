Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTGZTWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbTGZTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:22:34 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:3983 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S267561AbTGZTWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:22:34 -0400
Date: Sat, 26 Jul 2003 19:37:43 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting.
Message-ID: <20030726193743.B20667@devserv.devel.redhat.com>
References: <20030726172139.348342C24B@lists.samba.org> <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>; from torvalds@osdl.org on Sat, Jul 26, 2003 at 12:31:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 12:31:25PM -0700, Linus Torvalds wrote:
> 
> First off - we're not changing fundamental module stuff any more.

fair enough

> 
> On Sat, 26 Jul 2003, Rusty Russell wrote:
> > 
> > No, it would just leak memory.  Not really a concern for developers.
> > It's fairly trivial to hack up a backdoor "remove all freed modules
> > and be damned" thing for developers if there's real demand.
> 
> It's not just a developer thing. At least installers etc used to do some 
> device probing by loading modules and depending on the result.

yes but those same installers couldn't care less if the kernel
completely frees the memory of the module text or if it leaks that.
It won't even notice the difference....
