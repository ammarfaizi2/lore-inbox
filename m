Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTBCCRj>; Sun, 2 Feb 2003 21:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBCCRj>; Sun, 2 Feb 2003 21:17:39 -0500
Received: from dp.samba.org ([66.70.73.150]:7654 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265589AbTBCCRi>;
	Sun, 2 Feb 2003 21:17:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Sun, 02 Feb 2003 00:02:27 BST."
             <200302012302.h11N2R3U001433@eeyore.valparaiso.cl> 
Date: Mon, 03 Feb 2003 11:52:57 +1100
Message-Id: <20030203022709.83AA52C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302012302.h11N2R3U001433@eeyore.valparaiso.cl> you write:
> Rusty Russell <rusty@rustcorp.com.au> said:
> 
> [...]
> 
> > BTW, the reason for using the alias mechanism is that aliases are
> > useful in themselves: consider you write a "new_foo" driver, you can
> > do "MODULE_ALIAS("foo")" and so no userspace changes are neccessary.
> > module-init-tools 0.9.8 already supported this.
> 
> May I respectfully disagree again?

Hi Horst,

	Thoughtful and respecful criticism?  I didn't think that was
allowed on linux-kernel any more? 8)

> This is fundamentally broken, as it takes away the possibility of me
> (sysadmin) to load foo or old_foo. I end up with an (useless) foo, and a
> new_foo that aliases for foo, and soon I'd have even_newer_foo masquerading
> as foo too, and all hell breaks loose. The effect is bloat over just
> deleting foo in the first place, as it can't be used at all now.

Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
foo driver isn't found, and (2) the new driver author decides that
it's a valid replacement.

Whether (2) is ever justified, I'm happy leaving to the individual
author (I know, that makes me a wimp).

Consider another example: convenience aliases such as char-major-xxx.
Now, I'm not convinced they're a great idea anyway, but if people are
going to do this, I'd rather they did it in the kernel, rather than
some random userspace program.

I think the alias mechanism is valid, but you have a point about the
dangers, too.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
