Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTAJMSq>; Fri, 10 Jan 2003 07:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTAJMSq>; Fri, 10 Jan 2003 07:18:46 -0500
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:48142 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S264919AbTAJMSp>; Fri, 10 Jan 2003 07:18:45 -0500
Message-ID: <3E1EBCA2.F7974C07@compro.net>
Date: Fri, 10 Jan 2003 07:29:22 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
References: <slrnb1rlct.g2c.lunz@stoli.localnet> <200301091337.04957.jamesclv@us.ibm.com> <slrnb1rs3q.3u8.lunz@stoli.localnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:
> 
> jamesclv@us.ibm.com said:
> > I don't know of any way to do this in userland.  The whole point is
> > that the sibling processors are supposed to look like real ones.
> 
> That's unfortunately not always true. I'm writing a program that will
> run on a system that will be doing high-load routing. Testing has shown
> that we get better performance when binding each NIC's interrupts to a
> separate physical processor using /proc/irq/*/smp_affinity (especially
> when all the interrupts would hit the first CPU, another problem i've
> yet to address). That only works for real processors, though, not
> HT siblings.

Strange, I'm doing the very same thing (not with NICs though) using the
local_irq_desc
at the driver level or via /proc/irq/*/smp_affinity method and both work fine.
2.4.18 and 2.4.20 both work here but haven't actually used 2.4.19.
 
> 
> I'm writing a program to run on machines of unknown (by me)
> configuration, that will spread out the NIC interrupts appropriately.
> So userspace needs to know the difference, at least until interrupts can
> be automatically distributed by the kernel in a satisfactory way.

My userland app doesn't know the difference and works fine whether HT or not.
At least according to /proc/interrupts, xosview, and the actual performance of
my app.

Mark
