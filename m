Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbTFCMwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTFCMwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:52:01 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:36516 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S264986AbTFCMv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:51:59 -0400
Date: Tue, 3 Jun 2003 15:05:16 +0200
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>, mikpe@csd.uu.se,
       torvalds@transmeta.com
Subject: Re: [PATCH] Support for mach-xbox (updated)
Message-ID: <20030603130515.GC22531@h55p111.delphi.afb.lu.se>
References: <20030603091113.GD13285@h55p111.delphi.afb.lu.se> <20030603125940.GC13838@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603125940.GC13838@suse.de>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19NBTY-0006eR-00*SRzbOL7c4kQ*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 01:59:40PM +0100, Dave Jones wrote:
> Last 4 lines all use spaces instead of tabs.

darn.

>  >  targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
>  > +ifeq ($(CONFIG_X86_XBOX),y)
>  > +#XXX Compiling with optimization makes 1.1-xboxen 
>  > +#    crash while decompressing the kernel
>  > +CFLAGS_misc.o   := -O0
>  > +endif
> 
> curious. does it matter which version of gcc you used ?

Yes, only works with gcc3+

> this sounds like a band-aid for something else that needs fixing.

It sort of is (hence the XXX in the comment). But it's only when paging is
off. As soon as kernel is running everything is rock solid. It's probably
related to changed memoryaccess patterns.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
