Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265997AbSKFI3w>; Wed, 6 Nov 2002 03:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265999AbSKFI3w>; Wed, 6 Nov 2002 03:29:52 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:46598
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265997AbSKFI3u>; Wed, 6 Nov 2002 03:29:50 -0500
Date: Wed, 6 Nov 2002 03:37:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Philippe Elie <phil.el@wanadoo.fr>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
In-Reply-To: <3DC88B21.3030202@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0211060330490.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Philippe Elie wrote:

>  > [<c023d9d8>] serial8250_console_write+0x68/0x1f0
>  > [<c0121459>] __call_console_drivers+0x49/0x50
>  > [<c0121541>] call_console_drivers+0x71/0x100
>  > [<c012196d>] release_console_sem+0xbd/0x170
>  > [<c01217cc>] printk+0x18c/0x220
>  > [<c01170d5>] nmi_add_task+0xc5/0xe0
>  > [<c01177e0>] nmi_watchdog_tick+0x0/0x120
> 
> the oops occur during a NMI so I wonder how a NMI
> can occur and clobber ebx

Actually it didn't occur during the NMI, it just appears to be that way 
(ie don't consider the nmi_watchdog_tick ;) nmi_add_task is a registration 
function and is called from normal kernel context.

	Zwane
-- 
function.linuxpower.ca

