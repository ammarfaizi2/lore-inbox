Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUCAMC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUCAMC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:02:58 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:35336 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261231AbUCAMCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:02:55 -0500
Date: Mon, 1 Mar 2004 13:02:50 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Add a MODULE_VERSION macro
Message-ID: <20040301120250.GA30110@vana.vc.cvut.cz>
References: <CA71EA605D@vcnet.vc.cvut.cz> <20040301062725.844652C39D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301062725.844652C39D@lists.samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 04:41:24PM +1100, Rusty Russell wrote:
> Patch below: does it help?

Yes, much better:

/usr/src/linus/linux-2.6.3-c1663/scripts/Makefile.modpost:17: Trouble: /tmp/vmware-config1/vmnet-only/vmnet.ko
/usr/src/linus/linux-2.6.3-c1663/scripts/Makefile.modpost:18: *** Uh-oh, you have stale module entries. You messed with SUBDIRS,/usr/src/linus/linux-2.6.3-c1663/scripts/Makefile.modpost:19: do not complain if something goes wrong.

						Thanks,
							Petr Vandrovec

> 
> Rusty
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.4-rc1-bk1/scripts/Makefile.modpost tmp/scripts/Makefile.modpost
> --- linux-2.6.4-rc1-bk1/scripts/Makefile.modpost	2004-02-29 19:11:38.000000000 +1100
> +++ tmp/scripts/Makefile.modpost	2004-03-01 16:40:33.000000000 +1100
> @@ -14,7 +14,7 @@ __modules := $(shell head -q -n1 /dev/nu
>  modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
>  
>  ifneq ($(filter-out $(modules),$(__modules)),)
> -  $(warning Trouble: $(__modules) )
> +  $(warning Trouble: $(filter-out $(modules),$(__modules)))
>    $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
>    $(warning     do not complain if something goes wrong.)
>  endif
> 
