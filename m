Return-Path: <linux-kernel-owner+w=401wt.eu-S1161139AbXALW1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbXALW1E (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXALW1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:27:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39751 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161139AbXALW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:27:00 -0500
Date: Fri, 12 Jan 2007 14:26:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.20-rc5
Message-Id: <20070112142645.29a7ebe3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 14:27:48 -0500 (EST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> Ok, there it is, in all its shining glory.
> 

It still doesn't run Excel.

> A lot of developers (including me) will be gone next week for 
> Linux.Conf.Au,

me too.

> so you have a week of rest and quiet to test this, and 
> report any problems. 

I have a few fixes pending:

kvm-add-vm-exit-profiling-fix.patch
revert-nmi_known_cpu-check-during-boot-option-parsing.patch
blockdev-direct_io-fix-signedness-bug.patch
submitchecklist-update.patch
paravirt-mark-the-paravirt_ops-export-internal.patch
kvm-make-sure-there-is-a-vcpu-context-loaded-when.patch
kvm-fix-race-between-mmio-reads-and-injected-interrupts.patch
kvm-x86-emulator-fix-bit-string-instructions.patch
kvm-fix-asm-constraints-with-config_frame_pointer=n.patch
kvm-fix-bogus-pagefault-on-writable-pages.patch
rtc-sh-act-on-rtc_wkalrmenabled-when-setting-an-alarm.patch
fix-blk_direct_io-bio-preparation.patch
tlclk-bug-fix-misc-fixes.patch
mbind-restrict-nodes-to-the-currently-allowed-cpuset.patch
reiserfs-avoid-tail-packing-if-an-inode-was-ever-mmapped.patch

all of which are present in
http://userweb.kernel.org/~akpm/2.6.20-rc5-mm-fixes

The KVM and direct-io changes are significant, so if people are testing
those things, please be sure to have that patch applied.
