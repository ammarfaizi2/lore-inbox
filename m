Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUDJUlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUDJUlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:41:15 -0400
Received: from mail1.kontent.de ([81.88.34.36]:51363 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262110AbUDJUlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:41:12 -0400
Date: Sat, 10 Apr 2004 22:41:10 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.x] reboot fails on AMD Athlon System
Message-ID: <20040410204109.GA8520@kenny.sha-bang.local>
References: <20040404203254.GA2780@kenny.sha-bang.local> <20040409223843.GA563@kenny.sha-bang.local> <200404102038.20860.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404102038.20860.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 08:38:20PM +0300, Denis Vlasenko wrote:
> On Saturday 10 April 2004 01:38, Sascha Wilde wrote:
> > On Sun, Apr 04, 2004 at 10:32:54PM +0200, Sascha Wilde wrote:
> > > The conclusion so far: the code that hangs is not changed in
> > > comparison with Linux 2.4.24 which works for me, so the reason for the
> > > failure must be elsewhere in the setup of the hardware environment.
> > > Maybe in the apic disabling code, though it looks very similar to the
> > > 2.4.24 version, too.  Or in the setup of the AMD [Irongate/Viper]
> > > chip-set?
> >
> > I just build a kernel with everything special disabeled:  no APIC
> > support, no Athlon specific code (set i386), no AMD specific chipset
> > code (neither IDE/DMA nor AGP/DRI), no PM, no nothing...
> >
> > ...and it still refuses to reboot -- so the code change which
> > prevents my system from rebooting must be anywhere in some quite
> > generic code.  But where could this be?
> 
> How exactly do you reboot your box?

via "shutdown -r" or "reboot" from util-linux or via Sysrequest-Keys

Please read my former Messages on this Topic:

MID <20040312233614.GA641@kenny.sha-bang.local>
http://marc.theaimsgroup.com/?l=linux-kernel&m=107913498220501&w=2

and

MID <20040404203254.GA2780@kenny.sha-bang.local>
http://marc.theaimsgroup.com/?l=linux-kernel&m=108111101522751&w=2

you will notice that the reboot method is unrelated to the problem.

> I personally use a custom script. Attached.
> Hardwired to be in /app/shutdown-0.0.6/script,

Nice, but not relevant to the problem.

> Try it and track down what exactly does not work.

As I pointed out in my former mails: what hangs is the assembler code
called from machine_restart() -- this is the exact point of failture.
But the reason for the problem must be somewhere else, for the
failing rebootcode hasn't changed since 2.4.x which reboots on my
system just fine.

cheers
sascha
-- 
Sascha Wilde
To become a Jedi, use Emacs you have to.
