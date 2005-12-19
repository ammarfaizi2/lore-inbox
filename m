Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVLSHJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVLSHJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 02:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVLSHJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 02:09:17 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:30438
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1030256AbVLSHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 02:09:16 -0500
Date: Mon, 19 Dec 2005 02:08:50 -0500
From: Sonny Rao <sonny@burdell.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, clameter@sgi.com,
       anton@samba.org, sonnyrao@us.ibm.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051219070850.GA11956@kevlar.burdell.org>
References: <20051219051659.GA6299@kevlar.burdell.org> <1134974518.10035.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134974518.10035.5.camel@gaston>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 05:41:57PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-12-19 at 00:16 -0500, Sonny Rao wrote:
> > (apologies if this is a dup)
> > 
> > Hi, I'm crashing 2.6.15-rc5 when I try and offline the last and only CPU in a node on a ppc64 Power5, SMT was disabled.
> 
> First try on -rc6 just in case it's related to the SCSI fix (the bug was
> corrupting the SLAB) that got merged just after rc5 iirc.

Ok, tried it: same crash on -rc6

2:mon> t
[c000000d9f33b820] c000000000097cd0 .kfree+0x29c/0x2cc
[c000000d9f33b8d0] c00000000009c3a8 .cpuup_callback+0x4f8/0x5fc
[c000000d9f33b9c0] c00000000048ff4c .notifier_call_chain+0x68/0x9c
[c000000d9f33ba50] c000000000078da8 .cpu_down+0x1fc/0x368
[c000000d9f33bb40] c0000000002ae514 .store_online+0x88/0xe8
[c000000d9f33bbd0] c0000000002a8dd0 .sysdev_store+0x4c/0x68
[c000000d9f33bc50] c000000000111e70 .sysfs_write_file+0x100/0x1a0
[c000000d9f33bcf0] c0000000000c0360 .vfs_write+0x100/0x200
[c000000d9f33bd90] c0000000000c0570 .sys_write+0x54/0x9c
[c000000d9f33be30] c000000000008600 syscall_exit+0x0/0x18
--- Exception: c01 (System Call) at 000000000fe5ec10
SP (ffa204f0) is in userspace
2:mon> 

Sonny
