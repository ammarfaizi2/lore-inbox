Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278904AbRJ2ANG>; Sun, 28 Oct 2001 19:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278905AbRJ2AM5>; Sun, 28 Oct 2001 19:12:57 -0500
Received: from [212.34.128.4] ([212.34.128.4]:11112 "EHLO mailer.ran.es")
	by vger.kernel.org with ESMTP id <S278904AbRJ2AMg>;
	Sun, 28 Oct 2001 19:12:36 -0500
Date: Mon, 29 Oct 2001 01:12:58 +0100
From: victor <ixnay@infonegocio.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: victor <ixnay@infonegocio.com>
X-Priority: 3 (Normal)
Message-ID: <1871217837878.20011029011258@infonegocio.com>
To: erich@uruk.org
CC: linux-kernel@vger.kernel.org
Subject: Re: APM disable broken (was -> Re: 8139too on ABIT BP6 causes "eth0: transmit timed out" )
In-Reply-To: <E15xz5T-0008SA-00@trillium-hollow.org>
In-Reply-To: <E15xz5T-0008SA-00@trillium-hollow.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello erich,

Monday, October 29, 2001, 12:11:27 AM, you wrote:

i have a dual celeron in a bp6, i reflash de bios with
http://bp6.gamesquad.net/bios.phtml the bios revision
Final RU BIOS (newest Fianl Release BIOS from Abit)
and i have a ovislink 8139C chip and a hp 100mb switch and all works
fine


euo> Raphael Manfredi <Raphael_Manfredi@pobox.com> wrote:

euo> ...[recent 2.4-based kernel]...

>> but this problem is not specific to that kernel.  I've been having
>> it for a looong time.
>> 
>> Specifically, I get:
>> 
>>  NETDEV WATCHDOG: eth0: transmit timed out
euo> ...
>> and then the machine is dead, network-wise.  I have to reboot (reset).
>> 
>> Note that I am on an ABIT BP6 board, and I do get a lot of APIC errors
>> under heavy network traffic, which is what raises the above.
>> By heavy network traffic, I mean a 7 Mb/s full duplex (it's a 100 Mb/s
>> LAN).

euo> I had what looks like exactly this problem with my ABIT BP6 -based machine
euo> running RH 7.1, and the problem turned out to be the interaction between
euo> SMP and the APM BIOS, when APM is turned on.  A different network card,
euo> but the same symptom.  Another symptom I would occasionally see was a
euo> certain kind of hard-disk hang, but only on the integrated HPT366
euo> controller.

euo> I suggest you try either:

euo>   --  adding the "noapic" line to your kernel command-line (which will
euo>       lose you some I/O performance since normal interrupts will not be
euo>       handled APIC-style)
euo>   --  completely disabling APM from your kernel configuration.  Using
euo>       "apm=off/disabled" (I can't remember the exact one you're supposed
euo>       to use here) does not totally disable APM usage.


euo> This brings me to my other point.  During the Linux kernel startup
euo> code (in the early assembly), the APM BIOS checking code leaves the
euo> BIOS in the "connected" state even if the kernel option for disabling
euo> APM or the SMP forced disable of APM is triggered.

euo> This makes various motherboards (such as the ABIT BP6) unstable.

euo> The Right Thing to do would be to disconnect the APM BIOS if it is
euo> determined that APM support should be disabled.

euo> I could probably generate a patch to fix this if it looked like it would
euo> be accepted by the folks maintaining APM support...

euo> --
euo>     Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
euo> "Reality is truly stranger than fiction; Probably why fiction is so popular"
euo> -
euo> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
euo> the body of a message to majordomo@vger.kernel.org
euo> More majordomo info at  http://vger.kernel.org/majordomo-info.html
euo> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Best regards,
 victor                            mailto:ixnay@infonegocio.com

