Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTATPnr>; Mon, 20 Jan 2003 10:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTATPnr>; Mon, 20 Jan 2003 10:43:47 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25868 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266043AbTATPnq>; Mon, 20 Jan 2003 10:43:46 -0500
Date: Mon, 20 Jan 2003 15:52:50 +0000
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] initrd/mkinitrd still not working
Message-ID: <20030120155250.GB58326@compsoc.man.ac.uk>
References: <200301201457.PAA25276@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301201457.PAA25276@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18aeEE-00061j-00*tISYMjw8ai2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 03:57:22PM +0100, Mikael Pettersson wrote:

> >/lib/modules/2.5.56/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko
> 
> As to why the .o -> .ko name change was necessary, I have no idea.
> Rusty?

For one thing, it means you can do :

obj-$(CONFIG_OPROFILE) += oprofile.o
oprofile-y                              := $(DRIVER_OBJS) init.o
timer_int.o
oprofile-$(CONFIG_X86_LOCAL_APIC)       += nmi_int.o op_model_athlon.o \
                                           op_model_ppro.o op_model_p4.o

which is very nice. I don't know why they're installed like that though.

regards
john
-- 
"Anyone who quotes Rusty in their sig is an idiot."
	- me
