Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSKYFpu>; Mon, 25 Nov 2002 00:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKYFpu>; Mon, 25 Nov 2002 00:45:50 -0500
Received: from dp.samba.org ([66.70.73.150]:19111 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262442AbSKYFps>;
	Mon, 25 Nov 2002 00:45:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep 
In-reply-to: Your message of "Thu, 21 Nov 2002 07:39:12 -0800."
             <20021121073912.A15349@adam.yggdrasil.com> 
Date: Mon, 25 Nov 2002 16:47:08 +1100
Message-Id: <20021125055303.4E0A72C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021121073912.A15349@adam.yggdrasil.com> you write:
> 
> --xHFwDpU9dbj6ez1V
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> 	The following patch changes modprobe in module-init-tools-0.8
> to use modules.dep.
> 
> 	Benefits:
> 
> 	- deletes a net of 594 lines of source code
> 
> 	- shrinks modprobe from 14kB to 10kB (stripped, dynamically linked),
> 	  which is useful for boot images
> 
> 	- should make modprobe as fast on systems with a lot of modules as
> 	  it was with the user level module loader,
> 
> 	- Restores the "include" command to the aliases file, which makes
> 	  it simpler to have separate files for automatically generated
> 	  aliases and user customizations.
> 
> 	- minor: eliminates ELF dependence from modprobe user level code

Hmm, I like it.  But I prefer to pull the depmod code into the source
too, to keep it all under one roof.

The ELF dependence will go back in eventually, but that's trivial.

Hmm, Adam, do you want to reverse positions and become
module-init-tools maintainer?  I'll send patches to you, instead of
vice versa.  I'll release a 0.8 with the patches I have so far, then
hand it over if you want.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
