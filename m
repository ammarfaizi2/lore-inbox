Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWC0LWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWC0LWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWC0LWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:22:04 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:24812 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750893AbWC0LWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:22:03 -0500
Date: Mon, 27 Mar 2006 13:22:01 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Kurt Garloff <garloff@suse.de>
Subject: Re: [ANNOUNCE] OpenVZ patch for 2.6.16 and beta SUSE10.1 kernels
Message-ID: <20060327112201.GC16409@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
	Kurt Garloff <garloff@suse.de>
References: <4427B7DC.3040804@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4427B7DC.3040804@openvz.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 02:01:00PM +0400, Kirill Korotaev wrote:
> OpenVZ team is happy to announce the release of its virtualization
> solution based on 2.6.16 and beta SUSE10.1 kernels.
> 
> As in previous releases, OpenVZ 2.6.16 kernel patch includes:
> - virtualization
> - fine grained resource management (user beancounters)
> - 2 level disk quota
> 
> Coming soon new features (!):
> - virtualized AppArmor
> - dynamic virtual CPU adding/remove to/from VPS
> 
> More information about OpenVZ project is available at http://openvz.org/
> 
> Fine grained broken-out patch set can be found at
> http://download.openvz.org/kernel/broken-out/2.6.16-026test005.1/
> or at GIT repository at http://git.openvz.org/
> 
> About OpenVZ software
> ~~~~~~~~~~~~~~~~~~~~~
> 
> OpenVZ is a kernel virtualization solution which can be considered
> as a natural step in the OS kernel evolution: after multiuser and
> multitasking functionality there comes an OpenVZ feature of having
> multiple environments.

sorry, that's not an OpenVZ feature, that is a BSD feature
which is called Jails and was implemented on Linux more
than 3 years ago, in various implementations like:

Linux-VServer[1], FreeVPS[2], Linux-Jails[3]

> Virtualization lets you divide a system into separate isolated
> execution environments (called VPSs - Virtual Private Servers). From
> the point of view of the VPS owner (root), it looks like a stand-alone
> server. Each VPS has its own filesystem tree, process tree (starting
> from init as in a real system) and so on. The single-kernel approach
> makes it possible to virtualize with very little overhead, if any.
> 
> OpenVZ in-kernel modifications can be divided into several components:
> 
> 1. Virtualization and isolation.
> Many Linux kernel subsystems are virtualized, so each VPS has its own:
> - process tree (featuring virtualized pids, so that the init pid is 1);
> - filesystems (including virtualized /proc and /sys);
> - network (virtual network device, its own ip addresses,
>   set of netfilter and routing rules);
> - devices (if needed, any VPS can be granted access to real devices
>   like network interfaces, serial ports, disk partitions, etc);
> - IPC objects.
> 
> 2. Resource Management.
> This subsystem enables multiple VPSs to coexist, providing managed
> resource sharing and limiting.
> - User Beancounters is a set of per-VPS resource counters, limits,
>   and guarantees (kernel memory, network buffers, phys pages, etc.).
> - Two-level disk quota (first-level: per-VPS quota;
>   second-level: ordinary user/group quota inside a VPS)
> 
> Resource management is what makes OpenVZ different from other
> solutions of this kind (like Linux VServer or FreeBSD jails). There
> are a few resources that can be abused from inside a VPS (such as
> files, IPC objects, ...) leading to a DoS attack. User Beancounters
> prevent such abuses.

resource management is also part of Linux-VServer and Free-VPS
so nothing new here either ...

> As virtualization solution OpenVZ makes it possible to do the same
> things for which people use UML, Xen, QEmu or VMware, but there are
> differences:
> (a) there is no ability to run other operating systems
>     (although different Linux distros can happily coexist);
> (b) performance loss is negligible due to absense of any kind of
>     emulation;
> (c) resource utilization is much better.

also the web pages 'Description of Virtuozzo(tm) benefits over OpenVZ'
clearly state that:

Virtuozzo(TM) is SWsoft's virtualization and automation solution 
built on top of OpenVZ. Differently from OpenVZ, Virtuozzo(TM) 
is developed and designed to run production workloads in 24×7 
environments and provides significant improvements and additional 
functionality in the areas of stability, density, management tools, 
recovery, and other areas. 

Specific benefits of Virtuozzo(TM) compared to OpenVZ can be found 
below:

  Higher VPS density. Virtuozzo^(TM) provides efficient memory and
  file sharing mechanisms enabling higher VPS density and better
  performance of VPSs.

  Improved Stability, Scalability, and Performance. Virtuozzo(TM) 
  is designed to run 24×7 environments with production workloads 
  on hosts with up-to 32 CPUs.

---

best,
Herbert

[1] http://linux-vserver.org/
[2] http://www.freevps.com/
[3] http://mail.wirex.com/pipermail/linux-security-module/2005-June/6207.html

> Thanks,
> OpenVZ team.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
