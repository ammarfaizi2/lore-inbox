Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277267AbRJNSci>; Sun, 14 Oct 2001 14:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277273AbRJNSc2>; Sun, 14 Oct 2001 14:32:28 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:14315 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S277267AbRJNScU>;
	Sun, 14 Oct 2001 14:32:20 -0400
Date: Sun, 14 Oct 2001 20:32:46 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110141832.UAA08574@harpo.it.uu.se>
To: Take.Vos@binary-magic.com
Subject: Re: 2.4.12, Dell i8100 hangs when unpluggin power
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001 19:29:41 +0200, Take Vos wrote:
>I've been running 2.4.10 and 2.4.12 on my new Dell inspiron 8100, both of 
>which seems to hang as soon as I unplug the power coord, or close the lid.

If you have any of CONFIG_SMP, CONFIG_X86_UP_APIC, or CONFIG_X86_UP_IOAPIC
enabled, then it's a known problem: broken Dell BIOS. Just make sure
all three of these config options are off/disabled.

I'm (slowly) working on a solution. It involves moving dmi_scan to a
much earlier point in the init sequence (to setup_arch), but there
are some issues regarding its use of ioremap/iounmap to resolve first.

/Mikael
