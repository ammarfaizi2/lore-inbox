Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUCCKWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUCCKWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:22:46 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:4868 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262420AbUCCKWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:22:42 -0500
Date: Wed, 3 Mar 2004 07:21:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Marek Habersack <grendel@caudium.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] with 2.4.25 - same on several machines
In-Reply-To: <20040302223616.GA1439@thanes.org>
Message-ID: <Pine.LNX.4.44.0403030719300.2537-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Mar 2004, Marek Habersack wrote:

> Hey all,
> 
>   The machines are the same hardware (PIII, 512MB RAM, IDE, ext3 on /, xfs
> on the other partitions, 512MB of swap). Four machines oopsed with the same
> oopses:
> 
> Mar  1 17:47:24 colo19 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Mar  1 17:47:24 colo19 kernel:  printing eip:
> Mar  1 17:47:24 colo19 kernel: c01d0d6b
> Mar  1 17:47:24 colo19 kernel: *pde = 00000000
> Mar  1 17:47:24 colo19 kernel: Oops: 0000
> Mar  1 17:47:24 colo19 kernel: CPU:    0
> Mar  1 17:47:24 colo19 kernel: EIP:    0010:[fput+27/288]    Not tainted
> Mar  1 17:47:24 colo19 kernel: EFLAGS: 00010292
> Mar  1 17:47:24 colo19 kernel: eax: 57405660   ebx: 57405660   ecx: 00000079
> edx: 57405660
> Mar  1 17:47:24 colo19 kernel: esi: 00000000   edi: fffffff7   ebp: 00000000
> esp: dc75ff7c
> Mar  1 17:47:24 colo19 kernel: ds: 0018   es: 0018   ss: 0018
> Mar  1 17:47:24 colo19 kernel: Process apache (pid: 2873, stackpage=dc75f000)
> Mar  1 17:47:24 colo19 kernel: Stack: 00000018 00000018 dc75e000 57405660 fffffff7 000000b2 c01d0077 d9e6b0c0 
> Mar  1 17:47:24 colo19 kernel:        080ed9c4 00000296 00000000 c01b187b dc75ffb0 dc75e000 00000013 081dec1e 
> Mar  1 17:47:24 colo19 kernel:        bffffc18 c01a04d3 00000079 081deb6c 000000b2 00000013 081dec1e bffffc18 
> Mar  1 17:47:24 colo19 kernel: Call Trace:    [sys_write+247/320] [sys_time+27/96] [system_call+51/64] [handle_signal+315/
> 336]
> Mar  1 17:47:24 colo19 kernel: 
> Mar  1 17:47:24 colo19 kernel: Code: 8b 7d 08 ff 48 14 0f 94 c0 84 c0 75 18 8b 5c 24 08 8b 74 24 
> 
> The processes in all cases were different (a shell script, lsof, apache).
> The kernels are patched with grsec2 and libsata, but it doesn't seem to be
> relevant in this case. Could anybody shed some light on it? If necessary, I
> will post the machine configs and all the information needed to diagnose.

Hi Marek, 

<standard reply>

Can you reproduce the problem on vanilla 2.4.25 ? 

