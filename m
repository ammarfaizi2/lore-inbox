Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSJYMaw>; Fri, 25 Oct 2002 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261379AbSJYMaw>; Fri, 25 Oct 2002 08:30:52 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28052 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261377AbSJYMav>;
	Fri, 25 Oct 2002 08:30:51 -0400
Date: Fri, 25 Oct 2002 13:38:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: chrisl@vmware.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <20021025123857.GA1091@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, chrisl@vmware.com,
	linux-kernel@vger.kernel.org
References: <20021024230229.GA1841@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024230229.GA1841@vmware.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 04:02:29PM -0700, chrisl@vmware.com wrote:
 > It seems that /proc/cpuinfo will return the number of logical CPU.
 > If the machine has Intel Hyper-Thread enabled, that number is bigger
 > than physical CPU number. Usually twice as big.
 > 
 > My question is, what is the reliable way for user space program
 > to detect the number of physical CPU in the current machine?
 > 
 > If in it is in the kernel, I can read from cpu_sibling_map[]
 > or phys_cpu_id[]. But it seems not easy read that from
 > user space.
 > 
 > Of course I can do "gdb /proc/kcore" to get them. But is there
 > any better way?

You can perform cpuid instructions in userspace to get the
number of siblings per physical package.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
