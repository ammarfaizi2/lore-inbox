Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbTAIVti>; Thu, 9 Jan 2003 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268000AbTAIVth>; Thu, 9 Jan 2003 16:49:37 -0500
Received: from main.gmane.org ([80.91.224.249]:55239 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267999AbTAIVtf>;
	Thu, 9 Jan 2003 16:49:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason Lunz <lunz@falooley.org>
Subject: Re: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 21:57:09 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb1rs3q.3u8.lunz@stoli.localnet>
References: <slrnb1rlct.g2c.lunz@stoli.localnet> <200301091337.04957.jamesclv@us.ibm.com>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamesclv@us.ibm.com said:
> I don't know of any way to do this in userland.  The whole point is
> that the sibling processors are supposed to look like real ones.

That's unfortunately not always true. I'm writing a program that will
run on a system that will be doing high-load routing. Testing has shown
that we get better performance when binding each NIC's interrupts to a
separate physical processor using /proc/irq/*/smp_affinity (especially
when all the interrupts would hit the first CPU, another problem i've
yet to address). That only works for real processors, though, not
HT siblings.

I'm writing a program to run on machines of unknown (by me)
configuration, that will spread out the NIC interrupts appropriately.
So userspace needs to know the difference, at least until interrupts can
be automatically distributed by the kernel in a satisfactory way.

Jason

