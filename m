Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263205AbSJGXX0>; Mon, 7 Oct 2002 19:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJGXX0>; Mon, 7 Oct 2002 19:23:26 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:46610 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S263205AbSJGXXW>; Mon, 7 Oct 2002 19:23:22 -0400
Date: Tue, 8 Oct 2002 00:28:52 +0100
From: John Levon <levon@movementarian.org>
To: kai@tp1.ruhr-uni-bochum.de
Cc: linux-kernel@vger.kernel.org
Subject: vpath broken in 2.5.41
Message-ID: <20021007232852.GA35308@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17yhIz-0005c6-00*OBKZMLY.3/Y* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see vpath seems to have become broken in 2.5.41 build.

How now can I build the oprofile.o target from two directories ?

Namely,

	arch/i386/oprofile/Makefile:

vpath %.c = . $(TOPDIR)/drivers/oprofile
 
obj-$(CONFIG_OPROFILE) += oprofile.o
 
DRIVER_OBJS = \
        oprof.o cpu_buffer.o buffer_sync.o \
        event_buffer.o oprofile_files.o \
        oprofilefs.o oprofile_stats.o
 
oprofile-objs := $(DRIVER_OBJS) init.o timer_int.o
 
ifdef CONFIG_X86_LOCAL_APIC
oprofile-objs += nmi_int.o op_model_athlon.o op_model_ppro.o
endif
 
include $(TOPDIR)/Rules.make

with the DRIVER_OBJS sources in drivers/oprofile/

Since this was intentional, I assume I have to move my arch-dependent
parts back into drivers/ Kai ?

thanks
john

-- 
"I will eat a rubber tire to the music of The Flight of the Bumblebee"
