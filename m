Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSLTOew>; Fri, 20 Dec 2002 09:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLTOew>; Fri, 20 Dec 2002 09:34:52 -0500
Received: from mail.gmx.net ([213.165.65.60]:28098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262224AbSLTOev>;
	Fri, 20 Dec 2002 09:34:51 -0500
From: Felix Seeger <felix.seeger@gmx.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Next round of AGPGART fixes.
Date: Fri, 20 Dec 2002 15:42:48 +0100
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de>
In-Reply-To: <20021220124137.GA28068@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200212201542.48221.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 20 Dezember 2002 13:41 schrieb Dave Jones:
> Linus,
>  Please pull from bk://linux-dj.bkbits.net/agpgart to get at the
> following fixes..
>
> - AGP 3.0 now compiles as a module too.
> - beginnings of VIA KT400 AGP 3.0 support.
>   (Not functional yet, more work needed).
> - corrected handling of AGP capability bit in PCI headers for chipset
> drivers. This should fix the problems on I815 and similar chipsets.
[...]
> 		Dave

I am running 2.5.52bk5 with you GNU patch. Doesn't help.
I do a modprobe i810 and I get:

FATAL: Error inserting i810 
(/lib/modules/2.5.52bk5/kernel/drivers/char/drm/i810.ko): Cannot allocate 
memory

This is from dmesg:
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0x00000000, data=0x0
Call Trace:
 [<c01208a2>] check_timer_failed+0x42/0x50
 [<c0120cd7>] del_timer+0x17/0x80
 [<c4990dc5>] i810_takedown+0x45/0x3b0 [i810]
 [<c49952d6>] i810_stub_unregister+0x36/0x3d [i810]
 [<c49720e6>] 0xc49720e6
 [<c4997cc0>] +0x840/0x2720 [i810]
 [<c4997ca2>] +0x822/0x2720 [i810]
 [<c012a782>] sys_init_module+0xfe/0x178
 [<c0108d73>] syscall_call+0x7/0xb


thanks
have fun
Felix

