Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSLVNxu>; Sun, 22 Dec 2002 08:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLVNxu>; Sun, 22 Dec 2002 08:53:50 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:7442 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261624AbSLVNxt>; Sun, 22 Dec 2002 08:53:49 -0500
Date: Sun, 22 Dec 2002 09:01:50 -0500
From: Ben Collins <bcollins@debian.org>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.4.x ieee1394
Message-ID: <20021222140150.GJ504@hopper.phunnypharm.org>
References: <200212172033.gBHKX6A32611@hera.kernel.org> <20021222112613.GA8743@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021222112613.GA8743@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> After this change, firewire doesn't build for me when adding
> 1394 stuff directly into the kernel, i.e.
> 
>     CONFIG_IEEE1394=y
>     CONFIG_IEEE1394_OHCI1394=m
>     CONFIG_IEEE1394_SBP2=m
>     CONFIG_IEEE1394_RAWIO=y
> 
> The top level kernel Makefile has:
>     DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
> but there is no longer a ieee1394drv.o target.  This patch fixes 
> the problem.

Thanks Erik. I like this fix better than adding the cruft back into the
ieee1394 Makefile.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
