Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTK1SN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTK1SN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:13:27 -0500
Received: from ppp-62-245-210-190.mnet-online.de ([62.245.210.190]:60555 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263303AbTK1SNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:13:25 -0500
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: ross.alexander@uk.neceur.com, "Brendan Howes" <brendan@netzentry.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
	<200311281646.40171.s0348365@sms.ed.ac.uk>
From: Julien Oster <lkml-2344@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 28 Nov 2003 19:13:23 +0100
In-Reply-To: <200311281646.40171.s0348365@sms.ed.ac.uk> (Alistair John
 Strachan's message of "Fri, 28 Nov 2003 16:46:40 +0000")
Message-ID: <frodoid.frodo.87zneg8ipo.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

Hello Alistair,

> It's evidently a configuration problem, albeit BIOS, mainboard revision,
> memory quality, etc. because I and many others like me are able to run Linux
> 2.4/2.6 with all the options you tested and still achieve absolute stability,
> on the nForce 2 platform.

No, it's most evidently a mainboard problem, as everybody using an
ASUS A7N8X (Deluxe) reported so far that the mainboard will lock up
completely unless you turn of ACPI, APIC and local APIC. There is no
other possibility to work this lockup madness around, as many users of
that mainboard including me really tried *everything*.

We know that other NForce2 Mainboards don't have this kind of problem,
but sadly that isn't of any help whatsoever for us A7N8X users.

Unfortunately, my onboard SATA controller is significantly slower when
using XT-PIC interrupts (and I don't have many of them which aren't
crowded anyway). I can verify this by booting with ACPI and APIC
enabled and doing a simple hdparm -t multiple times on my SATA
softraid. I won't have much time to do this, though, since the
mainboard loves locking up very soon especially by doing hdparm -t.

HOWEVER, I tested it several times under Windows 2000 (I installed it
solely for this purpose, my machine used to be completely Redmond
free), and although Windows 2000 also routes the PCI interrupts via
APIC and ACPI, there's no such lockup occuring.

So, somehow, Linux should be able to allow the Asus A7N8X operate with
APIC and ACPI and any help in finally getting it in an usable state
would be strongly appreciated. I would have hacked the kernel myself,
but unfortunately I have no clue of the ACPI and APIC/local APIC stuff
in the kernel source.

Regards,
Julien
