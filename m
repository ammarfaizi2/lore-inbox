Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTBUPbi>; Fri, 21 Feb 2003 10:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTBUPbh>; Fri, 21 Feb 2003 10:31:37 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:7144 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267493AbTBUPbf>;
	Fri, 21 Feb 2003 10:31:35 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15958.18607.772631.502418@gargle.gargle.HOWL>
Date: Fri, 21 Feb 2003 16:41:35 +0100
To: Ion Badulescu <ionut@badula.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <Pine.LNX.4.44.0302210959090.17290-100000@guppy.limebrokerage.com>
References: <15958.15349.873243.599197@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0302210959090.17290-100000@guppy.limebrokerage.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu writes:
 > AMD 760MP and 760MPX, both have this problem.

Ok, AMD's chipsets are reasonable.

 > > Is the second CPU installed or not?
 > 
 > Installed.
 > 
 > > If the second CPU is installed, has it been disabled in BIOS?
 > 
 > It hasn't been disabled (the BIOS doesn't have that option).

That kills the noisy-bus theory.

 > Well, the second CPU is there, and there are no problems with the APIC and 
 > the IO-APIC if the kernel is compiled with CONFIG_SMP=y. Only the UP case 
 > causes the problem. So I don't think the bus itself is noisy, unless the 
 > noises are produced by the second CPU somehow, and we can't do anything 
 > about it because we're not touching that second CPU.

An UP_APIC kernel without IOAPIC shouldn't generate any APIC bus messages.
Have you checked if the BIOS has an option for choosing "PIC" or "APIC"
interrupt delivery? Try setting it to PIC mode.

 > I know that AMD's K7 APIC is supposed to be compatible with the Intel P6 
 > APIC, but do you think there might be some incompatibility between that 
 > that causes this? Or perhaps some undefined behavior we rely on, and which 
 > is different between Intel and AMD?...

None that I know of, to both questions.
All problems I've seen have been caused by non-Intel chipsets.

/Mikael
