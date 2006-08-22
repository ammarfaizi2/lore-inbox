Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHVTjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHVTjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWHVTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:39:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbWHVTi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:38:59 -0400
Date: Tue, 22 Aug 2006 12:38:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Message-Id: <20060822123850.bdb09717.akpm@osdl.org>
In-Reply-To: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 12:51:18 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> The almost the same config works fine with linux-2.6.18-rc4-mm1,
> kernel compiled with debug info, but for some reason there is no
> human readable trace. 
> 
> The kernel linux-2.6.18-rc4-mm2 + ntp-add-ntp_update_frequency-fix.patch
> 
> Any idea?
> 
> Here is log:
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 500k freed
> Write protecting the kernel read-only data: 860k
> Failed to execute /linuxrc. Attempting defaults...
> BUG: unable to handle kernel NULL pointer derefence at virtual adress 000000000
> print eip
> b7f106d0
> Oops: 0000 [#1]
> 8K_STACKS DEBUG_PAGEALLOC
> last sysfs file: /block/hda/range
> CPU: 0
> EIP: 0073:[<b7f106d0>] Not tainted VLI
> EFLAGS: 00000246 (2.6.18-rc4-mm2 #2)
> EIP is at 0xb7f106d0
> eax, ebx, edx, ecx, esi, edi, ebp: 0000000
> esp: bf843680
> ds, es, ss: 007b
> Process init (pid: 1, ti=c1166000 task=c11615d0 task.ti=c1166000)
> EIP: <b7f106d0>] 0xb7f106d0 SS:ESP 007b:bf83680

I tried to reproduce this with qemu but wasn't able to work out in less
than sixty seconds (== one attention-span) how to find and use a suitable
userspace image.  Help.  Could you please suggest where such an image can
be obtained and how it should be invoked to reproduce this?
