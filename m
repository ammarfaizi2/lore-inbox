Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVFILjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFILjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVFILjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:39:43 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:27528 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261505AbVFILjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:39:40 -0400
Subject: Re: IPv6 related BUG (./net/ipv6/exthdrs_core.c:ipv6_skip_exthdr())
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050609103052.GU19479@lug-owl.de>
References: <20050609103052.GU19479@lug-owl.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 09 Jun 2005 07:30:05 -0400
Message-Id: <1118316605.30110.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 12:30 +0200, Jan-Benedict Glaw wrote:
> Hi!
> 
> My bind wasn't working and this showed up in dmesg:
> 
>  ------------[ cut here ]------------
> kernel BUG at net/ipv6/exthdrs_core.c:80!
> invalid operand: 0000 [#1]
> SMP 
> Modules linked in: sd_mod capability commoncap ipt_REJECT iptable_filter ip_tables e100 floppy dm_mod pcspkr psmouse genrtc unix
> CPU:    1
> EIP:    0060:[<c02f8556>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.11.10lug-owl) 
> EIP is at ipv6_skip_exthdr+0x116/0x148
> eax: fffffff2   ebx: 00000000   ecx: 0000005c   edx: dabf3a4c
> esi: 00000080   edi: 00000082   ebp: cb9a63e0   esp: dabf3a40
> ds: 007b   es: 007b   ss: 0068
> Process named (pid: 11120, threadinfo=dabf2000 task=e706a5a0)
> Stack: 00000002 00296b00 dabf3a77 c03a4e40 00000028 cb9a63e0 f6fe6e00 dabf3b1c 
>        c01d7189 00000014 00000000 f6fe6210 ce3263c0 003263c0 c03a4e40 c0296876 
>        c03a4e40 00000000 c0296b00 80000000 c042f010 ce3263c0 c03aadec c042f020 
> Call Trace:
>  [<c01d7189>] selinux_parse_skb_ipv6+0x89/0x150

Known bug in SELinux.  The upstream fix for 2.6.12 was:
http://marc.theaimsgroup.com/?l=bk-commits-head&m=111444145104674&w=2
A more minimal fix that might be more appropriate for 2.6.11.x was:
http://marc.theaimsgroup.com/?l=linux-net&m=111417845723966&w=2

-- 
Stephen Smalley
National Security Agency

