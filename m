Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSI3Vp7>; Mon, 30 Sep 2002 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSI3Vp7>; Mon, 30 Sep 2002 17:45:59 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:12270 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261360AbSI3VpY>; Mon, 30 Sep 2002 17:45:24 -0400
Date: Mon, 30 Sep 2002 16:48:34 -0500 (CDT)
From: Kent Yoder <key@austin.ibm.com>
To: linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@pobox.com>
Subject: Oops on 2.5.39 was Re: [PATCH] pcnet32 cable status check
In-Reply-To: <3D98B25E.2010408@pobox.com>
Message-ID: <Pine.LNX.4.44.0209301639010.14068-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I just added mii_check_media() to drivers/net/mii.c.  It's in the latest 
>2.5.x snapshot, 
>ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.39-bk2.bz2

  That looks like just what the doctor ordered, but unfortunately it looks 
like 2.5.39-bk2 is oopsing on boot on this machine.  The boot freezes 
and at the top of the screen I can see what looks like the tail end of an 
oops (this is hand typed):

--------
wait_for_completion+0x12a/0x1e0
default_wake_function+0x0/0x40
try_to_wake_up+0x332/0x340
default_wake_function+0x0/0x40
set_cpus_allowed+0x22f/0x250
ksoftirqd+0x5b/0x110
ksoftirqd+0x0/0x110
kernel_thread_helper+0x5/0xc

[.. Linux NET starting.. other ACPI info ..]

ACPI Namespace successfully loaded at root c053f4bc

<freeze>

Kent

