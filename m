Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424628AbWKPVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424628AbWKPVVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424637AbWKPVVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:21:45 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:58345 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1424635AbWKPVVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:21:44 -0500
Date: Thu, 16 Nov 2006 16:21:40 -0500
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to go about debuging a system lockup?
Message-ID: <20061116212140.GP8236@csclub.uwaterloo.ca>
References: <20061116153444.GC8238@csclub.uwaterloo.ca> <9a8748490611161249t406768beqeaff0fc31f96e8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611161249t406768beqeaff0fc31f96e8df@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 09:49:06PM +0100, Jesper Juhl wrote:
> Well, I have a few ideas that are hopefully useul.
> 
> - If you have not done so already, then go in to the "Kernel Hacking"
> section of the kernel configuration and enable some (all?) of the
> debug options and see if that produces anything that will help you
> track down the problem.

I enabled the things that sounded useful.  I will try enabling the rest.

> - You could enable 'magic sysrq' and see if you can manage to get a
> backtrace with it when it hangs (see Documentation/sysrq.txt) (ohh and
> raise the console log level so you get all messages, including debug
> ones).

Yeah I did that.  No response to sysrq (at least not on the serial
console.  Maybe I should get a keyboard connector put on.)  Normally we
run without VGA/keyboard/etc, and just serial console.  Of course the
serial console requires working interrupts.  Not sure about the keyboard
driver.

> - You could also try kdb (http://oss.sgi.com/projects/kdb/) or kgdb
> (http://kgdb.linsyssoft.com/). That might help you pinpoint the
> failure.

Can I run that remotely somehow?  I never really looked at kdb or kgdb
before.

> See also : http://kerneltrap.org/node/112
> 
> - If you have (or can identify) an older, working, kernel version and
> you are confident that you can reproduce the problem reliably, then
> doing a git bisection search starting with your newest "known good"
> and oldest "known bad" kernel versions, should help you pinpoint the
> commit causing the breakage.

I don't know of a good version yet.  I so far don't know if there ever
was one.  This could even be a bug in the PCI hardware, or the way the
BIOS on this system on a board configured the PCI controller.  Maybe I
should go back and try a 2.4 kernel.

> Hope some of that helps :)

Well hopefully.

--
Len Sorensen
