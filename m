Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTLCQYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLCQYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:24:19 -0500
Received: from ppp-62-245-208-234.mnet-online.de ([62.245.208.234]:49537 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S265061AbTLCQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:24:01 -0500
To: ross.alexander@uk.neceur.com
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Brendan Howes" <brendan@netzentry.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OFF4FC9A17.547F8D5E-ON80256DF0.00356F93-80256DF0.00383157@uk.neceur.com>
From: Julien Oster <lkml-2314@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Wed, 03 Dec 2003 17:23:56 +0100
In-Reply-To: <OFF4FC9A17.547F8D5E-ON80256DF0.00356F93-80256DF0.00383157@uk.neceur.com> (ross
 alexander's message of "Tue, 2 Dec 2003 10:13:46 +0000")
Message-ID: <frodoid.frodo.87r7zldg4j.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ross.alexander@uk.neceur.com writes:

Hello Ross,

> I upgraded the BIOS about a week ago to 1007.  I personally found it
> to be less stable than 1006.

Yes, I can confirm that. With 1006, I could run 2.4.22-ac4 sometimes
for minutes, sometimes for several hours (2.6 however crashed right
away almost every time while still booting). With 1007, 2.4.22-ac4 is
also unstable.

> I don't believe it is a problem with my hardware combination since
> it has been stable for long periods of time.

Well, I tried everything with my hardware. Removing all cards,
disabling all onboard devices in BIOS setup etc... the only thing that
I didn't try yet was disabling the IDE controller, since I need the
PATA controller for booting.

> It is clear that the UP kernel is considerable more stable than the
> SMP kernel.  This is a very useful fact since it suggests that it is
> not a problem with the IDE device driver per se.  The whole purpose
> of my testing is to try to determine which options increased the
> stability and hence highlight where the problem could be.

Yes, you're right. Additionally, it's also very interesting that, at
least with BIOS 1006, 2.4.22-ac4 was much more stable with
APIC/LAPIC/ACPI enabled. It would at least run several hours.

> One of the reasons I don't like ACPI is the huge amount of
> additional complexity it adds and the amount of stuff it could screw
> up.

Unfortunately, I seem to need it to be able to use APIC (instead of
XT-PIC) interrupts. And my interrupts really are crowded, so finally
being able to enable the APIC would be a great thing. I already tested
it sometimes with interrupts on APIC, SATA definitely *is* faster (but
not for very long time, since it'll crash very soon :) )

> Now I have not heard that any of the VIA KTxxx based
> motherboards have any problems.

I had a VIA KT333, everything was fine. Then I bought the two SATA
drives and the ASUS A7N8X Deluxe v2.0. I changed nothing else. Now it
sucks.

> If this is true then the problem
> does not lie with the LAPIC, since that is in the processor, not the
> MB.

I can confirm that. My processor's very fine, it doesn't lockup with
the VIA board.

> The fact that it seems to only occur with the NForce2 chipset
> means it could well be some interrupt coming into the LAPIC from
> Interrupt Bus.  However I certainly don't claim to be an expert on
> this so I could well be talking complete crap.

I'm also far away from being an expert with that stuff. I would have
no problem to get some specific knowledge on APIC, but even then I
would simply have no clue where the problem might be in the kernel.

> Conclusion: More testing required.

Hmm, are you really sure? I mean, we tested *everything*, didn't we?
:-)

The only thing left is the removal of the onboard (PATA) IDE
controller. I can't do that, because my SATA disks have no bootable
system and my workstation is in heavy use for work at the
moment. However, it would be very interesting to see if it still locks
up.

Regards,
Julien

