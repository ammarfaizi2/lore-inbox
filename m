Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWKFKym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWKFKym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWKFKym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:54:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751676AbWKFKyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:54:41 -0500
Date: Mon, 6 Nov 2006 11:54:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
Message-ID: <20061106105442.GK5778@stusta.de>
References: <20061028200151.GC5619@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028200151.GC5619@gimli>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, did commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11 that is now 
in Linus' tree fix this issue?


On Sat, Oct 28, 2006 at 10:01:51PM +0200, Martin Lorenz wrote:
> With my recent kernel pulled from git on friday I see quite some DWARFs and
> other strange messages.
> 
> lots of those:
> [18038.721000] thinkpad_ec: thinkpad_ec_request_row: bad end STR3:
> (0x11:0x00)->0x80
> 
> this was said to be triggered by the combination of hdaps and tp_smapi but I
> do not load the tp_smapi module ...
> hdaps is configured
> 
> and quite a few of those:
> 
> [18504.980000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
> [18504.980000]  [<c0103bdd>] dump_trace+0x69/0x1af
> [18504.980000]  [<c0103d3b>] show_trace_log_lvl+0x18/0x2c
> [18504.980000]  [<c01043da>] show_trace+0xf/0x11
> [18504.980000]  [<c01044dd>] dump_stack+0x15/0x17
> [18504.980000]  [<c0135e94>] unlock_cpu_hotplug+0x3d/0x66
> [18504.980000]  [<f92e67f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
> [18504.980000]  [<c012ccb1>] run_workqueue+0x83/0xc5
> [18504.980000]  [<c012d5d5>] worker_thread+0xd9/0x10c
> [18504.980000]  [<c012fb36>] kthread+0xc2/0xf0
> [18504.980000]  [<c010398b>] kernel_thread_helper+0x7/0x10
> [18504.980000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> [18504.980000]
> [18504.980000] Leftover inexact backtrace:
> [18504.980000]
> [18504.980000]  =======================
> 
> 
> full config and dmesg is in
> http://www.lorenz.eu.org/~mlo/kernel/config.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.gz
> http://www.lorenz.eu.org/~mlo/kernel/dmesg.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.boot
> http://www.lorenz.eu.org/~mlo/kernel/dmesg.2.6.19-rc3-e1-ie-tp-43.3+1757-g18462d6b-dirty.run
> 
> and more
> http://www.lorenz.eu.org/~mlo/kernel/?C=M;O=D
> 
> greets
>   mlo
> --
> Dipl.-Ing. Martin Lorenz
> 
>             They that can give up essential liberty 
> 	    to obtain a little temporary safety 
> 	    deserve neither liberty nor safety.
>                                    Benjamin Franklin
> 
> please encrypt your mail to me
> GnuPG key-ID: F1AAD37D
> get it here:
> http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D
> 
> ICQ UIN: 33588107
