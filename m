Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUADEal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUADEal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:30:41 -0500
Received: from dp.samba.org ([66.70.73.150]:51588 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265117AbUADEak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:30:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Juergen Quade <quade@hs-niederrhein.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module_param( byte ... ) missing? 
In-reply-to: Your message of "Sat, 03 Jan 2004 17:40:26 BST."
             <20040103164026.GA29962@hsnr.de> 
Date: Sun, 04 Jan 2004 13:06:07 +1100
Message-Id: <20040104043037.EC4042C0DC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040103164026.GA29962@hsnr.de> you write:
> Rusty,
> 
> using the "byte"-datatype as module parameter throws a compile error.
> Other than stated in the comment of the headerfile <linux/moduleparam.h>
> 
> 	/* Helper functions: type is byte, short, ushort, int, uint, long,
> 	   ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
> 	   param_set_XXX and param_check_XXX. */
> 	#define module_param_named(name, value, type, perm)
> 	...
> 	
> the datatype _byte_ seems not be implemented.
> Have you dropped it intentionally?

No, just not implemented; the comment is overzealous.  

Of course, you can implement byte in two ways: you can do it in your
own module (effectively a private type), or in kernel/params.c.  I'd
prefer the former, and if lots of modules use it, we move it to
kernel/params.c.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
