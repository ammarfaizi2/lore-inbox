Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031487AbWKVK1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031487AbWKVK1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031488AbWKVK1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:27:51 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:37557 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1031487AbWKVK1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:27:50 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 22 Nov 2006 11:28:05 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, gregkh@suse.de,
       Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061115102122.GQ22565@stusta.de> <200611151135.48306.dada1@cosmosbay.com>
In-Reply-To: <200611151135.48306.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221128.05769.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 11:35, Eric Dumazet wrote:
> On Wednesday 15 November 2006 11:21, Adrian Bunk wrote:
> > Subject    : x86_64: oprofile doesn't work
> > References : http://lkml.org/lkml/2006/10/27/3
> > Submitter  : Prakash Punnoor <prakash@punnoor.de>
> > Status     : unknown
>

I hit the same problem on i386 architecture too, if CONFIG_ACPI is not set.

# opcontrol --setup --event=RESOURCE_STALLS:1000 --vmlinux=$VMFILE
# opcontrol --start
/usr/bin/opcontrol: line 911: /dev/oprofile/0/enabled: No such file or 
directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/event: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/count: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/kernel: No such file or 
directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/user: No such file or directory
/usr/bin/opcontrol: line 911: /dev/oprofile/0/unit_mask: No such file or 
directory
Using 2.6+ OProfile kernel interface.
Reading module info.
Using log file /var/lib/oprofile/oprofiled.log
Daemon started.
Profiler running.

# ls -l /dev/oprofile/
total 0
drwxr-xr-x 1 root root 0 Nov 22 11:18 1
-rw-r--r-- 1 root root 0 Nov 22 11:18 backtrace_depth
-rw-r--r-- 1 root root 0 Nov 22 11:18 buffer
-rw-r--r-- 1 root root 0 Nov 22 11:18 buffer_size
-rw-r--r-- 1 root root 0 Nov 22 11:18 buffer_watershed
-rw-r--r-- 1 root root 0 Nov 22 11:18 cpu_buffer_size
-rw-r--r-- 1 root root 0 Nov 22 11:18 cpu_type
-rw-rw-rw- 1 root root 0 Nov 22 11:18 dump
-rw-r--r-- 1 root root 0 Nov 22 11:18 enable
-rw-r--r-- 1 root root 0 Nov 22 11:18 pointer_size
drwxr-xr-x 1 root root 0 Nov 22 11:18 stats
# dmesg | grep oprofile
oprofile: using NMI interrupt.
# opcontrol --version
opcontrol: oprofile 0.9.2 compiled on Nov 22 2006 11:24:09

Eric


