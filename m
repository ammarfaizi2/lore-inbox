Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753532AbWKFRhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbWKFRhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbWKFRhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:37:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15122 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753568AbWKFRhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:37:09 -0500
Date: Mon, 6 Nov 2006 18:37:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian <christiand59@web.de>
Cc: Dave Jones <davej@redhat.com>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061106173707.GR5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611051832.13285.christiand59@web.de> <20061106060021.GD5778@stusta.de> <200611061643.14217.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611061643.14217.christiand59@web.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 04:43:13PM +0100, Christian wrote:
> Am Montag, 6. November 2006 07:00 schrieb Adrian Bunk:
> > On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
> > > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
> > > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
> > > >  > Could this be a problem?
> > > >  > --------------------
> > > >  > ...
> > > >  > CONFIG_ACPI_PROCESSOR=m
> > > >  > ...
> > > >  > CONFIG_X86_POWERNOW_K8=y
> > > >
> > > > Hmm, possibly.  Christian, does it work again if you set them both to
> > > > =y ?
> > >
> > > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it
> > > work again!
> >
> > You said 2.6.18 worked for you.
> >
> > Did you have CONFIG_ACPI_PROCESSOR=y in 2.6.18, or did
> > CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=y work for you in 2.6.18?
> 
> It worked with CONFIG_ACPI_PROCESSOR=m in 2.6.18-rc7. Since 2.6.19-rc1 it 
> doesn't work anymore with CONFIG_ACPI_PROCESSOR=m.
> 
> user@ubuntu:~/Projekte/linux-2.6.18-rc7$ uname -a
> Linux ubuntu.localnet 2.6.18-rc7 #2 SMP Wed Sep 13 11:28:41 CEST 2006 x86_64 
> GNU/Linux
> 
> user@ubuntu:~/Projekte/linux-2.6.18-rc7$ lsmod | grep -Ei "processor|acpi|
> power"
> powernow_k8            16096  1
> freq_table              6848  2 powernow_k8,cpufreq_stats
> cpufreq_powersave       3584  0
> asus_acpi              20644  0
> processor              36872  2 powernow_k8,thermal
> 
> 
> user@ubuntu:~/Projekte/linux-2.6.18-rc7$ grep -i 
> ACPI_PROCESSOR /boot/config-2.6.18-rc7
> CONFIG_ACPI_PROCESSOR=m
> 
> user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
> grep -Ei "POWERNOW_K8" /boot/config-2.6.18-rc7
> CONFIG_X86_POWERNOW_K8=m
> CONFIG_X86_POWERNOW_K8_ACPI=y
> 
> +++ There's a difference in 2.6.19! CONFIG_X86_POWERNOW_K8_ACPI is gone +++
> 
> user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
> grep -Ei "POWERNOW_K8" /boot/config-2.6.19-rc1
> CONFIG_X86_POWERNOW_K8=y
>....

It's gone because you changed CONFIG_X86_POWERNOW_K8 from m to y.

> -Christian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

