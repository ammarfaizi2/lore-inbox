Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTLDMSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTLDMSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 07:18:06 -0500
Received: from mail.netzentry.com ([157.22.10.66]:19209 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S261552AbTLDMSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 07:18:01 -0500
Message-ID: <3FCF25F2.6060008@netzentry.com>
Date: Thu, 04 Dec 2003 04:17:54 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dan@dcrdev.demon.co.uk
CC: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Creswell wrote:

Thanks for the input, I'll pass it to the list.

Most of these Athlon victims are UP users, in fact, I
believe they are exclusively UP. Does MPS 1.1/1.4 play a role
in a UP system ever? I dont think the NForce2 chipset,
where we are seeing these hard hangs (no ping, no screen,
no blinking cursor, no toggling the caps lock, nothing) is
capable of SMP operation.

Now whats interesting is you finger the IDE as a potential
culprit and think its very low level. Interesting.

By the way, I've had trouble with SMP on a Tyan board with an
i840 chipset with Linux before - I was never able to resolve
the issue and had to return the board.

I've beaten on an Intel SR1300 and SR2300 dual Xeon (aka
Micron's Netframe 1610/2610 aka Sun 60x / 65x) and never run
into these hangs with kernels up to 2.4.22. The motherboard
is an Intel SE7501WV2 .


 >Hi,
 >Been following this thread silently for a while and thought
 >I'd drop you
 >a line as I have some other data you may find useful.
 >
 >My machine is a dual Xeon with 2Gb, E1000 NIC, MPT LSI SCSI
 >disks and an
 >IDE CDROM.
 >
 >2.6-test9 is only stable on this machine with noapic passed in the
 >kernel parameters - otherwise, it lock's up in no time flat.
 >I can also
 >run this kernel in single-processor mode with the APIC enabled and
 >that's stable.
 >
 >2.4.23-rc2 runs fine on the same machine with the APIC enabled
 >in SMP mode.
 >
 >2.4.23-rc5 locks up on this machine if I use the same .config as
for
 >-rc2.  However, if I disable ACPI and pass "pci=noacpi" to the
kernel,
 >this too runs fine.
 >    - Seems like the ACPI changes in -rc3 are a problem for my
machine.
 >
 >All of these behaviors have been observed with MPS 1.4 (I've
changed
 >that BIOS setting to 1.1 today in preparation for more testing of
the
 >above to see if that makes a difference).
 >
 >I mention all of this because none of my lock-ups have happened
whilst
 >accessing the IDE subsystem.  I *have* had lockups with
simultaneous
 >network and disk access and I've also seen it with simply
 >mouse-waggling.  I suspect that the problem is *very* low-level
and
 >likely related to the interrupt load.  In my case, the problems
only
 >seem to occur with SMP configurations which makes me suspect there
may
 >be a locking/simultaneous update problem.
 >
 >Oh, forgot to say, my motherboard is a Tyan Thunder S2665
 >(based on the
 >intel E7505 chipset).
 >
 >Hope that helps,
 >
 >Dan.

