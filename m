Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270021AbRHUAUr>; Mon, 20 Aug 2001 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270023AbRHUAUi>; Mon, 20 Aug 2001 20:20:38 -0400
Received: from p052.as-l031.contactel.cz ([212.65.234.244]:32004 "EHLO
	p052.as-l031.contactel.cz") by vger.kernel.org with ESMTP
	id <S270021AbRHUAU2>; Mon, 20 Aug 2001 20:20:28 -0400
Date: Tue, 21 Aug 2001 01:45:17 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alexandre Hautequest <hquest@fesppr.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPX in 2.4.[5-9]
Message-ID: <20010821014517.G1394@ppc.vc.cvut.cz>
In-Reply-To: <998343425.3b818301718cd@webmail.fesppr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998343425.3b818301718cd@webmail.fesppr.br>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 06:37:05PM -0300, Alexandre Hautequest wrote:
> Hello all.
> 
> What's the actual IPX support in linux? Is it broken since 2.4.7? Or i just need
> to recompile my tools against a new kernel version -- the old ones was compiled
> in a 2.4.5 -- with any patch, option, whatever?
> 
> hquest@condor:~$ dmesg
> (snip)
> IPX Portions Copyright (c) 1995 Caldera, Inc.
> IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
> hquest@condor:~$ /sbin/ifconfig -v eth0    
> eth0      Link encap:Ethernet  HWaddr 00:00:F8:08:BD:A1  
>           inet addr:172.16.40.2  Bcast:172.16.255.255  Mask:255.255.0.0
>           IPX/Ethernet 802.2 addr:AC100000:0000F808BDA1
> (snip)
> hquest@condor:~$ slist
> slist: Server not found (0x8847) in ncp_open
> hquest@condor:~$ _
> 
> Not flaming anyone, just questioning.

If you do not have ncpfs-2.2.0.16, but anything newer, or older than 2.2.0.12,
then it should work. If it reports 8847, it means that you have misconfigured
network (search for 8847 on support.novell.com). You have either no server
on 802.2, or you (or admin) disabled Reply To Get Nearest Server on all
servers connected to your wire. You must enable it at least on one of them.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
