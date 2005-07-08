Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVGHTLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVGHTLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVGHTLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:11:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:59369 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262777AbVGHTLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:11:05 -0400
To: "Adnan Khaleel" <Adnan.Khaleel@newisys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux
References: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2005 21:11:03 +0200
In-Reply-To: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com.suse.lists.linux.kernel>
Message-ID: <p738y0hp0zc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adnan Khaleel" <Adnan.Khaleel@newisys.com> writes:

> Hi there,
> 
> I'm a hardware designer and I'm interested in collecting dynamic execution traces in Linux. I've looked at several trace toolkits available for Linux currently but none of them offer the level of detail that I need. Ideally I would like to be able to record the instructions being executed on an SMP system along with markers for system or user space in addition to process id. I need these traces in order to evaluate the data sharing, coherence traffic etc in larger SMP systems. I've tried several other approaches to collecting execution traces namely via machine emulators etc but so far I've been dogged with the problem of trying to get any OS up and running stably on a multiprocessor configuration.
> 
> Is there a Linux kernel patch that will let me do this? I have considered using User Mode Linux but I'm not sure if this is the correct approach either - if any of you think that this is the easier path, I'd be interested in exploring this more. Other things that have crossed my mind is to use a gdb or the kernel debugger interface in order to collect the instructions but I'm not sure if this would be the correct path. Also I do require the tool/patch to be  stable enough so that I can run commercial benchmarks on it reliably.
> 
> I understand that recording every executed instruction can considerably slow down the application and may be considerably different from the freely running application but nevertheless I think that some trace is better than no trace and this is where I am at the moment.
> 
> If any of you have had experiences in profiling the kernel etc by collecting actual kernel instructions executed, I'd be interested in seeing if that may be extended for my purpose.

While some CPUs (like Intel P4) have ways to do such hardware
tracing I know of no free tool that uses it. There are some user
space tools to collect at user space, but they probably won't help you.

Your best bet is likely some full system simulator with tracing
support like Simics, SimNow, bochs, qemu.  The first two might be able to 
run enterprise benchmarks.

-Andi
