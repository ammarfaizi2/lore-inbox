Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTFCMml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbTFCMmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:42:40 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:21407 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264985AbTFCMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:42:38 -0400
Date: Tue, 3 Jun 2003 13:59:40 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       mikpe@csd.uu.se, torvalds@transmeta.com
Subject: Re: [PATCH] Support for mach-xbox (updated)
Message-ID: <20030603125940.GC13838@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Anders Gustafsson <andersg@0x63.nu>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, mikpe@csd.uu.se,
	torvalds@transmeta.com
References: <20030603091113.GD13285@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603091113.GD13285@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 11:11:13AM +0200, Anders Gustafsson wrote:
 > Updated according to Sam and Mikaels comments.

you missed one 8-)

 > +static void xbox_pic_cmd(u8 command)
 > +{
 > +	outw_p(((XBOX_PIC_ADDRESS) << 1),XBOX_SMB_HOST_ADDRESS);
 > +        outb_p(SMC_CMD_POWER, XBOX_SMB_HOST_COMMAND);
 > +        outw_p(command, XBOX_SMB_HOST_DATA);
 > +        outw_p(inw(XBOX_SMB_IO_BASE),XBOX_SMB_IO_BASE);
 > +        outb_p(0x0a,XBOX_SMB_GLOBAL_ENABLE);
 > +}

Last 4 lines all use spaces instead of tabs.

 >  targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 > +ifeq ($(CONFIG_X86_XBOX),y)
 > +#XXX Compiling with optimization makes 1.1-xboxen 
 > +#    crash while decompressing the kernel
 > +CFLAGS_misc.o   := -O0
 > +endif

curious. does it matter which version of gcc you used ?
this sounds like a band-aid for something else that needs fixing.

 		Dave

