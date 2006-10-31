Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423543AbWJaQ01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423543AbWJaQ01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423554AbWJaQ01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:26:27 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:43961 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1423543AbWJaQ00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:26:26 -0500
Message-Id: <454787AB.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 31 Oct 2006 17:28:11 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Martin Lorenz" <martin@lorenz.eu.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
References: <20061028200151.GC5619@gimli> <p73hcxklfoy.fsf@verdi.suse.de>
 <20061031160815.GM27390@gimli>
In-Reply-To: <20061031160815.GM27390@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you perhaps get us arch/i386/kernel/{entry,process}.o,
.config, and (assuming you can reproduce the original problem)
the raw stack dump obtained with a sufficiently high kstack=
option?

Thanks, Jan

>>> Martin Lorenz <martin@lorenz.eu.org> 31.10.06 17:08 >>>
On Tue, Oct 31, 2006 at 03:31:41PM +0100, Andi Kleen wrote:
> Martin Lorenz <martin@lorenz.eu.org> writes:
> 
> > and quite a few of those:
> > 
> > [18504.980000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
> > [18504.980000]  [<c0103bdd>] dump_trace+0x69/0x1af
> > [18504.980000]  [<c0103d3b>] show_trace_log_lvl+0x18/0x2c
> > [18504.980000]  [<c01043da>] show_trace+0xf/0x11
> > [18504.980000]  [<c01044dd>] dump_stack+0x15/0x17
> > [18504.980000]  [<c0135e94>] unlock_cpu_hotplug+0x3d/0x66
> > [18504.980000]  [<f92e67f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
> > [18504.980000]  [<c012ccb1>] run_workqueue+0x83/0xc5
> > [18504.980000]  [<c012d5d5>] worker_thread+0xd9/0x10c
> > [18504.980000]  [<c012fb36>] kthread+0xc2/0xf0
> > [18504.980000]  [<c010398b>] kernel_thread_helper+0x7/0x10
> > [18504.980000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> 
> What gcc / binutils version do you use?
$ gcc --version
gcc (GCC) 4.1.2 20061020 (prerelease) (Debian 4.1.1-17)

dpkg says:
ii  gcc                        4.1.1-13

$ ar --version
GNU ar 2.17 Debian GNU/Linux

dpkg says:
ii  binutils                   2.17-3


> 
> > [18504.980000]
> > [18504.980000] Leftover inexact backtrace:
> > [18504.980000]
> > [18504.980000]  =======================
> > 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/ 

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D 

ICQ UIN: 33588107
