Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbTIOWYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTIOWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:24:44 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:1210 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261612AbTIOWYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:24:42 -0400
Subject: Re: Need fixing of a rebooting system
From: Chris Meadors <clubneon@hereintown.net>
To: Kevin Breit <mrproper@ximian.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F66249A.3020308@ximian.com>
References: <1063496544.3164.2.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
	 <3F6450D7.7020906@ximian.com>
	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>
	 <1063561687.10874.0.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>
	 <3F64FEAF.1070601@ximian.com>
	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
	 <1063650478.1516.0.camel@localhost.localdomain>
	 <1063653132.224.32.camel@clubneon.priv.hereintown.net>
	 <3F66249A.3020308@ximian.com>
Content-Type: text/plain
Message-Id: <1063664654.19299.10.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 18:24:14 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19z1lx-0003hD-0M*vG6k1.QT/zg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 16:44, Kevin Breit wrote:

> /proc/cpuinfo says:
> 
> model name:   Celeron (Coppermine)
> 
> So my configuration for the first 5 main menu items that are enabled in 
> makeconfig are:
> 
> * Prompt for developer and/or incomplete code/drivers
>   * Select only drivers expected to compile cleanly
>   * Select only drivers that don't need compile-time external firmware
> 
> * Support for paging of anonymous memory
>    * System V IPC
>    * BSD Process Accounting
>    * Sysctl support
> * Subarchitecture Type (PC-compatible)
> * Processor family (Pentium-II/Celeron(pre-Coppermine))

You can pick the Pentium-III here, since you have a Coppermine core
Celeron.  But this will almost surely not be any part of the solution to
the problem.

> * Preemptible Kernel
> * Machine Check Exception
> * /dev/cpu/microcode
> * /dev/cpu/*/msr
> * /dev/cpu/*/cpuid
> * BIOS Enhanced Disk Drive calls determine boot disk

I'd turn this off, just to see if it makes any change.  It says it is
"believed to be safe", but it is experimental, and your controller BIOS
almost surely does not support it.

> * Power Management support
>    *Full ACPI Support (minus the ASUS Laptop Extras and Toshiba Laptop 
> Extras)
> 
> Do you see anything in that list which I should look into ditching first?

Other than the EDD setting, I see nothing.  What do you have in the next
choice after ACPI, the APM stuff?

Also, can you see anything on the screen before it reboots?  There is
nothing after "Uncompressing kernel..."?  Just boom, it reboots?

There isn't much that can trigger a reboot that early on.

-- 
Chris

