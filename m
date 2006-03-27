Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWC0KBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWC0KBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWC0KBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:01:07 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:22441 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750834AbWC0KBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:01:06 -0500
Message-ID: <4427B7DC.3040804@openvz.org>
Date: Mon, 27 Mar 2006 14:01:00 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Kurt Garloff <garloff@suse.de>,
       Kir Kolyshkin <kir@openvz.org>, devel@openvz.org
Subject: [ANNOUNCE] OpenVZ patch for 2.6.16 and beta SUSE10.1 kernels
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Do-Not-Rej: Toldya
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OpenVZ team is happy to announce the release of its virtualization
solution based on 2.6.16 and beta SUSE10.1 kernels.

As in previous releases, OpenVZ 2.6.16 kernel patch includes:
- virtualization
- fine grained resource management (user beancounters)
- 2 level disk quota

Coming soon new features (!):
- virtualized AppArmor
- dynamic virtual CPU adding/remove to/from VPS

More information about OpenVZ project is available at http://openvz.org/

Fine grained broken-out patch set can be found at
http://download.openvz.org/kernel/broken-out/2.6.16-026test005.1/
or at GIT repository at http://git.openvz.org/

About OpenVZ software
~~~~~~~~~~~~~~~~~~~~~

OpenVZ is a kernel virtualization solution which can be considered as a
natural step in the OS kernel evolution: after multiuser and
multitasking functionality there comes an OpenVZ feature of having
multiple environments.

Virtualization lets you divide a system into separate isolated
execution environments (called VPSs - Virtual Private Servers). From the
point of view of the VPS owner (root), it looks like a stand-alone
server. Each VPS has its own filesystem tree, process tree (starting
from init as in a real system) and so on. The  single-kernel approach
makes it possible to virtualize with very little overhead, if any.

OpenVZ in-kernel modifications can be divided into several components:

1. Virtualization and isolation.
Many Linux kernel subsystems are virtualized, so each VPS has its own:
- process tree (featuring virtualized pids, so that the init pid is 1);
- filesystems (including virtualized /proc and /sys);
- network (virtual network device, its own ip addresses,
   set of netfilter and routing rules);
- devices (if needed, any VPS can be granted access to real devices
   like network interfaces, serial ports, disk partitions, etc);
- IPC objects.

2. Resource Management.
This subsystem enables multiple VPSs to coexist, providing managed
resource sharing and limiting.
- User Beancounters is a set of per-VPS resource counters, limits,
   and guarantees (kernel memory, network buffers, phys pages, etc.).
- Two-level disk quota (first-level: per-VPS quota;
   second-level: ordinary user/group quota inside a VPS)

Resource management is what makes OpenVZ different from other solutions
of this kind (like Linux VServer or FreeBSD jails). There are a few
resources that can be abused from inside a VPS (such as files, IPC
objects, ...) leading to a DoS attack. User Beancounters prevent such
abuses.

As virtualization solution OpenVZ makes it possible to do the same
things for which people use UML, Xen, QEmu or VMware, but there are
differences:
(a) there is no ability to run other operating systems
     (although different Linux distros can happily coexist);
(b) performance loss is negligible due to absense of any kind of
     emulation;
(c) resource utilization is much better.

Thanks,
OpenVZ team.


