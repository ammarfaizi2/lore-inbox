Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTA1JIM>; Tue, 28 Jan 2003 04:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTA1JHK>; Tue, 28 Jan 2003 04:07:10 -0500
Received: from dp.samba.org ([66.70.73.150]:35307 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261523AbTA1JHF>;
	Tue, 28 Jan 2003 04:07:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] [PATCH] new modversions implementation 
In-reply-to: Your message of "Sat, 25 Jan 2003 22:56:37 BST."
             <20030125215637.GA3571@mars.ravnborg.org> 
Date: Tue, 28 Jan 2003 18:06:17 +1100
Message-Id: <20030128091625.4790C2C2AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030125215637.GA3571@mars.ravnborg.org> you write:
> On Sat, Jan 25, 2003 at 12:44:39PM -0600, Kai Germaschewski wrote:
> 
> Just some small nit-picking..
> 
> 	Sam
> 
> diff -Nru a/kernel/module.c b/kernel/module.c
> --- a/kernel/module.c   Sat Jan 25 12:25:07 2003
> +++ b/kernel/module.c   Sat Jan 25 12:25:07 2003
> 
> +       kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
> +                                      - __start___ksymtab_gpl);
> 
> The member "num_syms" says something about number of symbols,
> but is contains the syms_size. Misleading name.

I think you've missed the declaration:

extern const struct kernel_symbol __start___ksymtab[];
extern const struct kernel_symbol __stop___ksymtab[];
extern const struct kernel_symbol __start___ksymtab_gpl[];
extern const struct kernel_symbol __stop___ksymtab_gpl[];

Thanks for the feedback!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
