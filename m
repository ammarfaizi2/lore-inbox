Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272685AbTHEMiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272729AbTHEMhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:37:53 -0400
Received: from [66.212.224.118] ([66.212.224.118]:20235 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272726AbTHEMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:37:12 -0400
Date: Tue, 5 Aug 2003 08:25:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
In-Reply-To: <20030805122354.GL13456@rdlg.net>
Message-ID: <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
References: <20030805122354.GL13456@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Robert L. Harris wrote:

> Unable to handle kernel paging request at virtual address 8011c560
>  printing eip:
> 8011c560
> *pde = 00000000
> Oops: 0000
> CPU:    1
> EIP:    0010:[<8011c560>]    Not tainted
> EFLAGS: 00010286
> eax: 8011c560   ebx: c037f754   ecx: 00000040   edx: c0357980
> esi: 00000040   edi: c037f740   ebp: c037ef40   esp: c1e19f28
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c1e19000)
> Stack: c011c47d 00000001 c0358180 00000001 fffffffe 00000040 c011c1ff c0358180 
>        c037ef40 c0351800 00000000 c1e19f74 00000046 c0108bdb c0105400 c1e18000 
>        c0105400 00000040 c02f5b44 00000000 c010ae78 c0105400 c1e18000 c1e18000 
> Call Trace: [<c011c47d>] [<c011c1ff>] [<c0108bdb>] [<c0105400>] [<c0105400>] 
>    [<c010ae78>] [<c0105400>] [<c0105400>] [<c010542c>] [<c01054a2>] [<c0117e7f>] 
>    [<c0117d8e>] 
> 
> Code:  Bad EIP value.
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing

Could have been someone removing a module without unregistering an 
interrupt handler. But that's just guessing.

> Can someone please tell me what this means or how to figure it out?  The
> machine is offline for the next 12 hours unfortunately due to lack of
> remote help.  I do have similar machines with the same kernel/hardware
> if I need to run any commands against this output.  I don't have access
> to any specific files on the machine though.

You don't specify which kernel this is, it appears to be 2.4 something. 
Please run this through ksymoops (man ksymoops)

-- 
function.linuxpower.ca
