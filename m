Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292940AbSB0U6Z>; Wed, 27 Feb 2002 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSB0U6E>; Wed, 27 Feb 2002 15:58:04 -0500
Received: from a.smtp-out.sonic.net ([208.201.224.38]:43465 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S292943AbSB0U5h>; Wed, 27 Feb 2002 15:57:37 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Wed, 27 Feb 2002 12:57:36 -0800
From: dhinds <dhinds@sonic.net>
To: Andreas Roedl <flood@flood-net.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia problems with IDE & cardbus
Message-ID: <20020227125736.A1502@sonic.net>
In-Reply-To: <20020227111008.A13182@sonic.net> <20020227204649.92C08AA40@flood-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227204649.92C08AA40@flood-net.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 09:49:51PM +0100, Andreas Roedl wrote:
> 
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_proc_dev_init
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_setup
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_shutdown
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol 
> dldwd_proc_dev_cleanup
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_reset
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: unresolved symbol dldwd_interrupt
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: insmod 
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o failed
> /lib/modules/2.4.18/pcmcia/orinoco_cs.o: insmod orinoco_cs failed
> 
> ?

Did you read my explanation?

You've somehow ended up loading the hermes module from the 2.4.18
kernel tree, and the orinoco_cs module from the pcmcia-cs package.
"modprobe" is probably getting confused by having several modules with
the same names, in different directories.

If you use just the pcmcia-cs modules, (or just the kernel modules),
then everything should work fine on 2.4.18.

-- Dave
