Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbUKEKHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUKEKHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbUKEKGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:06:07 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45509 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262643AbUKEKEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:04:09 -0500
Subject: Re: ext3 and nfsd do not work under load (Re: x86_64, LOCKUP on
	CPU0, kjournald)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jaakko =?ISO-8859-1?Q?Hyv=E4tti?= <jaakko@hyvatti.iki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041101013150.2ab0aaa5.akpm@osdl.org>
References: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
	 <Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi>
	 <20041101013150.2ab0aaa5.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1099648985.3793.39.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 05 Nov 2004 21:03:05 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-11-01 at 20:31, Andrew Morton wrote:
> Jaakko Hyvätti <jaakko@hyvatti.iki.fi> wrote:
> >
> > 
> > Here is another oops and lockup, with nfsd now there in the trace also:
> > 
> > Unable to handle kernel paging request at ffffffff00000808 RIP:
> > <ffffffff80161b37>{cache_alloc_refill+329}
> > PML4 103027 PGD 0
> > Oops: 0002 [1] SMP
> > CPU 0
> > Modules linked in: w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
> > Pid: 1968, comm: nfsd Not tainted 2.6.8-1.521smp
> 
> That's a vendor kernel of some form, yes?
> 
> > RIP: 0010:[<ffffffff80161b37>] <ffffffff80161b37>{cache_alloc_refill+329}
> 

I've seen similar things here.  Last night on 2.6.9 + kdb, win4lin,
bootsplash & suspend2 (no cycles done), I could lock up my desktop
machine by doing

cat /dev/hda > /dev/null

Then

cat /proc/meminfo

a few times. I was going to stress test suspend, but never got that far
:>

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

