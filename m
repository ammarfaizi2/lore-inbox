Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbREWIew>; Wed, 23 May 2001 04:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbREWIem>; Wed, 23 May 2001 04:34:42 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:32773 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S263012AbREWIef>; Wed, 23 May 2001 04:34:35 -0400
Message-ID: <3B0B7616.B9F09B8B@stud.uni-saarland.de>
Date: Wed, 23 May 2001 08:34:30 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: arvai@scripps.edu, linux-kernel@vger.kernel.org
CC: manfred@colorfullife.com
Subject: Re: noapic doesn't quite work as advertised
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 've got a tyan s2520 motherboard (dual PIII + i840) which is having a 
> problem with APIC errors. I tried running with noapic, but there were 
> still errors, although fewer. Does anyone have any idea what is going 
> on? I'm running 2.4.4 and software raid5, which generates a lot of 
> interrupts. 

noapic only prevents that hardware interrupts are rerouted through the
io apic.

The inter processor interrupts still use the apic bus, and it's
impossible to use SMP without IPIs.

> Right now I'm running with noapic and nosmp and so far this seems to 
> be working. I really would like to be able to use the second 
> cpu so any suggestion would be greatly appreciated. 

It could be a hardware problem, or the board uses an unusal io apic
that's not properly handled.
If you boot without noapic, are there any unusual message in the boot
log?

Perhaps
	MP-BIOS bug
	unknown io apic
etc.
