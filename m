Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbSJMXKE>; Sun, 13 Oct 2002 19:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSJMXKE>; Sun, 13 Oct 2002 19:10:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34311 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261759AbSJMXKD>; Sun, 13 Oct 2002 19:10:03 -0400
Date: Mon, 14 Oct 2002 00:15:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Message-ID: <20021014001552.Q23142@flint.arm.linux.org.uk>
References: <200210132310.QAA01044@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210132310.QAA01044@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Oct 13, 2002 at 04:10:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 04:10:01PM -0700, Adam J. Richter wrote:
> 	I have no objection to replacing or supplementing the reboot
> notifier chain with a method in struct device_driver, but let's not
> overload these methods with ambiguous semantics.  I do not want to
> call thirty functions that primarily return memory to various memory
> allocators, mark a bunch of inodes as invalid, and otherwise arrange
> things so that the kernel can smoothly continue to run user level
> programs when, in fact, we just want to pull the reset line on the
> computer.

And what about setups where you can't pull the reset line from software.
I have several machines here like that.  And one of them needs software
to talk to the cards to put them back into a sane state before rebooting.

"rebooting" in this particular case is "turn MMU off, jump to location 0"

And I never said anything about needing to allocate memory to do this.
I agree with you that suspending devices on reboot _is_ silly.  However,
that's not what I was proposing.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

