Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSLUJld>; Sat, 21 Dec 2002 04:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSLUJld>; Sat, 21 Dec 2002 04:41:33 -0500
Received: from holomorphy.com ([66.224.33.161]:49353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266852AbSLUJlc>;
	Sat, 21 Dec 2002 04:41:32 -0500
Date: Sat, 21 Dec 2002 01:48:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.40 64GB highmem BUG()
Message-ID: <20021221094856.GH9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200212210943.BAA08993@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212210943.BAA08993@adam.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> This is not reproducible here with 2.5.52-mm2. Is the initrd required
>> to trigger this?

On Sat, Dec 21, 2002 at 01:43:20AM -0800, Adam J. Richter wrote:
> 	Yes, the initrd seems to be required.  It happens when
> the initrd attempts to mount /proc (it runs a shell script that
> starts by setting PATH, mounting /dev, and mounting /proc).
> 	I've verified that under 2.5.52 the problem occurs with
> CONFIG_HIGHME64G and not with CONFIG_HIGHMEM4G.  Actually, now the
> problem is a BUG() at slab.c:1451, which is also memory corruption,
> and I suspect just an evolution of the same problem from 2.5.40.
> 	Anyhow, in case it helps you, I've put the vmlinux and initrd
> that produce this problem in
> ftp://ftp.yggdrasil.com/private/adam/for-wli/.  Note that the ramdisk
> has kernel modules that don't match the kernel but that's not the
> issue, as I configured that kernel to have a different version name.
>        Thanks for your attention to this problem.

I'll take it for a spin sometime in the next 6-12 hours.


Bill
