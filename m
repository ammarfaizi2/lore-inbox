Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTAPBqk>; Wed, 15 Jan 2003 20:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTAPBqj>; Wed, 15 Jan 2003 20:46:39 -0500
Received: from dp.samba.org ([66.70.73.150]:10129 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266961AbTAPBqj>;
	Wed, 15 Jan 2003 20:46:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: Re: [PATCH] Proposed module init race fix. 
In-reply-to: Your message of "Wed, 15 Jan 2003 15:21:22 BST."
             <D4E37953801@vcnet.vc.cvut.cz> 
Date: Thu, 16 Jan 2003 12:48:57 +1100
Message-Id: <20030116015535.355A22C133@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <D4E37953801@vcnet.vc.cvut.cz> you write:
> On 15 Jan 03 at 20:06, Rusty Russell wrote:
> > In message <200301150846.AAA01104@adam.yggdrasil.com> you write:
> > >   Could you explain this "random behavior" of 2.4 a bit more?
> > > As far as I know, if a module's init function fails, it must
> > > unregister everything that it has registered up to that point.
> > 
> > And if someone's using it, the module gets unloaded underneath them.
> 
> No. Unregister will go to sleep until it is safe to unregister
> driver. See unregister_netdevice for perfect example, but I'm sure
> that there are other unregister functions which make sure that after
> unregister it is OK to destroy everything.

And see remove_proc_entry, or notifier_chain_unregister for
counterexamples.  No doubt there are others.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
