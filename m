Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTIRUqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTIRUqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:46:46 -0400
Received: from [193.138.115.2] ([193.138.115.2]:17169 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262139AbTIRUqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:46:44 -0400
Date: Thu, 18 Sep 2003 22:45:18 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: Greg KH <greg@kroah.com>
cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 - 27 New warnings
In-Reply-To: <20030918182407.GB1846@kroah.com>
Message-ID: <Pine.LNX.4.56.0309182242090.10753@jju_lnx.backbone.dif.dk>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
 <20030918182407.GB1846@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Sep 2003, Greg KH wrote:

> On Wed, Sep 17, 2003 at 11:23:03PM -0700, John Cherry wrote:
> > drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not used
>
> Hm, what compiler version are you using to get this warning?
> This should not be happening (the usb_midi_ids are used in the
> MODULE_DEVICE_TABLE() macro to export the info to userspace), and I
> can't duplicate the warning here with gcc versions 3.3.1 or 2.96 (Red
> Hat rawhide and Red Hat 7.3 respectively)
>
I just tested this with gcc 3.2.2 (Slackware Linux 9.0) and I do get that
warning :

  gcc -Wp,-MD,drivers/usb/class/.usb-midi.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686
-Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include
-DKBUILD_BASENAME=usb_midi -DKBUILD_MODNAME=usb_midi -c -o
drivers/usb/class/.tmp_usb-midi.o drivers/usb/class/usb-midi.c
drivers/usb/class/usb-midi.h:150: warning: `usb_midi_ids' defined but not
used



Jesper Juhl <jju@dif.dk>


