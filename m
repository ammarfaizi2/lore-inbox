Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSJUWWQ>; Mon, 21 Oct 2002 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJUWWQ>; Mon, 21 Oct 2002 18:22:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55680 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261737AbSJUWWP>;
	Mon, 21 Oct 2002 18:22:15 -0400
Date: Mon, 21 Oct 2002 15:31:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Stephen Hemminger <shemminger@osdl.org>
cc: "David S. Miller" <davem@redhat.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44 crash on reboot
In-Reply-To: <1035238760.1186.22.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210211530500.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 Oct 2002, Stephen Hemminger wrote:

> The following happens on 2-way SMP box every time I reboot using
> serial console. Not sure if it is a socket or inode problem but it looks
> like a close race.
> --------------------------------------------------------------------
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> c01b1a38
> *pde = 00000000
> Oops: 0000
> ide-cd cdrom soundcore mga agpgart autofs nfs lockd sunrpc eepro100 mii
> mousede
> CPU:    0
> EIP:    0060:[<c01b1a38>]    Not tainted
> EFLAGS: 00010246
> EIP is at device_shutdown+0x78/0x9e
            ^^^^^^^^^^^^^^^

Actually, it appears to be a problem accessing the global device list. 
Could you please send me your .config (private email is fine).

	-pat

