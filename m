Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbUB0RjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUB0RjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:39:15 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:44960 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263058AbUB0RjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:39:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 27 Feb 2004 18:38:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Add a MODULE_VERSION macro
Cc: rusty@rustcorp.com.au
X-mailer: Pegasus Mail v3.50
Message-ID: <CA71EA605D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 04 at 6:51, Linux Kernel Mailing List wrote:
> ChangeSet 1.1713, 2004/02/26 22:51:58-08:00, akpm@osdl.org
> 
>     [PATCH] Add a MODULE_VERSION macro

...

> diff -Nru a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> --- a/scripts/Makefile.modpost  Thu Feb 26 23:11:35 2004
> +++ b/scripts/Makefile.modpost  Thu Feb 26 23:11:35 2004
> @@ -10,10 +10,11 @@
...  
>  
>  ifneq ($(filter-out $(modules),$(__modules)),)
> +  $(warning Trouble: $(__modules) )
>    $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
>    $(warning     do not complain if something goes wrong.)
>  endif

Hi Rusty,
  what is this line supposed to do, except making it impossible
to build kernel modules in temporary directories? Now when I build
out-of-tree modules, I get 'Trouble:' followed by approximate 16000
characters listing paths to all modules I have in kernel, for no
apparent reason (I know that I removed some module I built in /tmp...
why kernel should care, that module is gone forever), so it makes 
all warning & error messages completely lost 5 screens away.
  
  Can you remove this 'Trouble:' message, or at least provide some
way to disable that message (and two warnings below it too, they
serve no useful purpose AFAICT, as they trigger whenever you'll remove
some module from directory where you built it) ? Or at least make it
useful: print only modules which are missing, not all modules.
                                        Thanks,
                                                Petr Vandrovec
                                                

