Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTAOQs3>; Wed, 15 Jan 2003 11:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTAOQs3>; Wed, 15 Jan 2003 11:48:29 -0500
Received: from ns1.netroute.cz ([212.71.168.2]:64152 "HELO pop3.netroute.cz")
	by vger.kernel.org with SMTP id <S266717AbTAOQs2>;
	Wed, 15 Jan 2003 11:48:28 -0500
Date: Wed, 15 Jan 2003 17:57:10 +0100
From: Jan Hudec <bulb@ucw.cz>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops on server that just started hanging and crashing
Message-ID: <20030115165710.GN11998@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	linux-kernel@vger.kernel.org
References: <20030114185033.GA20921@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114185033.GA20921@rdlg.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 01:50:33PM -0500, Robert L. Harris wrote:
> Ok, after some data collection since (didn't know only the box in
> question could decode an oops...):
> 
> System panic'd and has started hanging without a visual panic:

Started since when? Since recompiling and booting new kernel and/or
kernel modules or not? Because various panics and oopses often result
from hardware failure. Also, did the kernel crash just once, did it
crash several times at the same or similar address or did it crash
several times on completely different addresses?

For hard lockups, you could enable the NMI watchdog. That would give
even if it otherwise locks up completely. See
Documentation/nmi_watchdog.txt in kernel sources. However that is useful
if you don't suspect hardware (unfortunately almost anything - power
source, memory, CPU, bus controlers... - can cause seemingly random
lockups and oopses).

> Dual-amd 1.5Ghz
> 512Meg Ram
> 3Ware IDE RAID controller
>   16x160Gig disks, Making up 4 RAID5 arrays
> 
> 
> 
> ksymoops 2.3.4 on i686 2.4.19-ac4.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.19-ac4/ (default)
>      -m /boot/System.map-2.4.19-ac4 (specified)
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
> Warning (compare_maps): ksyms_base symbol __wake_up_sync_R__ver___wake_up_sync not found in System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol i2o_sys_init_R__ver_i2o_sys_init not found in System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol set_cpus_allowed_R__ver_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
> invalid operand: 0000

Absolutely sure the System.map is for the kernel that generated the
oops? Absolutely sure the same modules are loaded?

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
