Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbTAOI7E>; Wed, 15 Jan 2003 03:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAOI7E>; Wed, 15 Jan 2003 03:59:04 -0500
Received: from dp.samba.org ([66.70.73.150]:62183 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265851AbTAOI7D>;
	Wed, 15 Jan 2003 03:59:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposed module init race fix. 
In-reply-to: Your message of "Wed, 15 Jan 2003 00:46:26 -0800."
             <200301150846.AAA01104@adam.yggdrasil.com> 
Date: Wed, 15 Jan 2003 20:06:43 +1100
Message-Id: <20030115090757.DB0522C109@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301150846.AAA01104@adam.yggdrasil.com> you write:
> On 2003-01-15, Rusty Russell wrote:
> >It's possible to start using a module, and then have it fail
> >initialization.  In 2.4, this resulted in random behaviour.  One
> >solution to this is to make all interfaces two-stage: reserve
> >everything you need (which might fail), the activate them.  This
> >means changing about 1600 modules, and deprecating every interface
> >they use.
> 
> 	Could you explain this "random behavior" of 2.4 a bit more?
> As far as I know, if a module's init function fails, it must
> unregister everything that it has registered up to that point.

And if someone's using it, the module gets unloaded underneath them.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
