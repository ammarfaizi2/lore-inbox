Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWG2MPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWG2MPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWG2MPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:15:40 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:62772 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932118AbWG2MPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:15:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pv01jgIZO9fueYv2d31eOvsCmC0gzK487GmZYmciV5Ik2v34SmJleWMKcZaTgsBCIhSDStvA26kePro+9PvbejvcSyf0a3xrMLw0qVU/2jSz1z6F9wjpo+KnIWQbAQuVGyLo8YEAqYDzJika/YtlphWNQRsd9+tNjh1qNTZ8ntk=
Message-ID: <6bffcb0e0607290515q50556634vf3121d8dd2431691@mail.gmail.com>
Date: Sat, 29 Jul 2006 14:15:39 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc2-mm1
Cc: "Dave Jones" <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607271159y1ca4db0mb95854f626b1617a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	 <6bffcb0e0607271159y1ca4db0mb95854f626b1617a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 27/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Between
> remove-incorrect-unlock_kernel-from-failure-path-in.patch
> and
> reiserfs-use-generic_file_open-for-open-checks.patch
> I have noticed a lot of this bugs

I was wrong (as usually :)

git-cpufreq.patch is causing this error

> Netfilter messages via NETLINK v0.30.
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
> BUG: warning at /usr/src/linux-work1/kernel/cpu.c:51/unlock_cpu_hotplug()
>  [<c0103f0a>] show_trace_log_lvl+0x58/0x152
>  [<c010460e>] show_trace+0xd/0x10
>  [<c010472d>] dump_stack+0x19/0x1b
>  [<c013991e>] unlock_cpu_hotplug+0x2f/0x59
>  [<f98fe1e8>] store_speed+0x8f/0x9b [cpufreq_userspace]
>  [<c0287c7e>] store+0x37/0x48
>  [<c0199cd3>] sysfs_write_file+0xa6/0xcc
>  [<c0167567>] vfs_write+0xab/0x157
>  [<c0167baa>] sys_write+0x3b/0x60
>  [<c0102ea1>] sysenter_past_esp+0x56/0x8d
> DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Leftover inexact backtrace:
>  [<c010460e>] show_trace+0xd/0x10
>  [<c010472d>] dump_stack+0x19/0x1b
>  [<c013991e>] unlock_cpu_hotplug+0x2f/0x59
>  [<f98fe1e8>] store_speed+0x8f/0x9b [cpufreq_userspace]
>  [<c0287c7e>] store+0x37/0x48
>  [<c0199cd3>] sysfs_write_file+0xa6/0xcc
>  [<c0167567>] vfs_write+0xab/0x157
>  [<c0167baa>] sys_write+0x3b/0x60
>  [<c0102ea1>] sysenter_past_esp+0x56/0x8d

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
