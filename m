Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTATTDs>; Mon, 20 Jan 2003 14:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTATTDr>; Mon, 20 Jan 2003 14:03:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34576 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266640AbTATTDq>;
	Mon, 20 Jan 2003 14:03:46 -0500
Date: Mon, 20 Jan 2003 20:12:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Levon <levon@movementarian.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [2.5] initrd/mkinitrd still not working
Message-ID: <20030120191250.GA1314@mars.ravnborg.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200301201457.PAA25276@harpo.it.uu.se> <20030120155250.GB58326@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120155250.GB58326@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 03:52:50PM +0000, John Levon wrote:
> > As to why the .o -> .ko name change was necessary, I have no idea.
> > Rusty?
> 
> For one thing, it means you can do :
> 
> obj-$(CONFIG_OPROFILE) += oprofile.o
> oprofile-y                              := $(DRIVER_OBJS) init.o
> timer_int.o
> oprofile-$(CONFIG_X86_LOCAL_APIC)       += nmi_int.o op_model_athlon.o \
>                                            op_model_ppro.o op_model_p4.o

The above mentioned possibility to list 'members' of a composite object
by means of either:
oprofile-y
or
oprofile-objs

has nothing to do with the .ko extension.
But that feature may have been added in the same time-frame though.


I do not recall exactly whay Kai introduced the .ko extension, but
without checking I assume that makes it easier / possible to do some
added tricks in the makefiles.

	Sam
