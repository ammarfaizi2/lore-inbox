Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbTLFLfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbTLFLfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:35:30 -0500
Received: from ppp-62-245-209-10.mnet-online.de ([62.245.209.10]:5504 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S265096AbTLFLWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:22:43 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>
	<3FD1199E.2030402@gmx.de> <20031206081848.GA4023@localnet>
From: Julien Oster <lkml-2315@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sat, 06 Dec 2003 12:22:41 +0100
In-Reply-To: <20031206081848.GA4023@localnet> (cheuche+lkml@free.fr's
 message of "Sat, 6 Dec 2003 09:18:49 +0100")
Message-ID: <frodoid.frodo.87zne6chry.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cheuche+lkml@free.fr writes:

Hello,

>> So gals and guys, try disabling cpu disconnect in bios and see whether 
>> aopic now runs stable.

> Yes that fix it. Well time will tell but I cannot make it crash with
> hdparm -tT or cat /dev/hda so far. I'm dumping hda to /dev/null right
> now.
> After testing to make it crash, I used athcool to reenable CPU
> disconnect, and guess what, test after that just crashed the box.
> You found the problem, congratulations.

Well, now I'm stunned.

With APIC and ACPI enabled, my machine isn't even able to boot
completely, it'll most certainly crash before the init scripts are
finished.

Now, I modified the init scripts to do "athcool off" as the first
thing at all (I don't have any "CPU disconnect" BIOS setting) and it
not only booted, but I even can't seem to make it crash using my
hdparm/grep/whatever tests...

I don't know if it's "rock solid" yet, but at least the difference is
huge. It really seems like that made the problem go away!

Regards,
Julien
