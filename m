Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270063AbRHGEUp>; Tue, 7 Aug 2001 00:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270064AbRHGEUg>; Tue, 7 Aug 2001 00:20:36 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:58315 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270063AbRHGEUV>;
	Tue, 7 Aug 2001 00:20:21 -0400
Message-Id: <200108070420.f774KXl04696@www.2ka.mipt.ru>
Date: Tue, 7 Aug 2001 08:23:12 +0400
From: John Polyakov <johnpol@2ka.mipt.ru>
To: Steve VanDevender <stevev@efn.org>
Cc: justin@soze.net, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <15215.27296.959612.765065@localhost.efn.org>
In-Reply-To: <20010807042810.A23855@foobar.toppoint.de>
	<Pine.LNX.4.33.0108062047310.17919-100000@kobayashi.soze.net>
	<15215.27296.959612.765065@localhost.efn.org>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac1; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Mon, 6 Aug 2001 21:12:16 -0700
Steve VanDevender <stevev@efn.org> wrote:

SV> Justin Guyett writes:
>> On Tue, 7 Aug 2001, David Spreen wrote:
>> 
>> > I was just searching for swap-encryption-solutions in the lkml-archive.
>> > Did I get the point saying ther's no way to do swap encryption
>> > in linux right now? (Well, a swapfile in an encrypted kerneli
>> > partition r something like that is not really what I want to
>> > do I think).
>> 
>> What's the benefit?  Sure, attackers have to know that encrypted swap is
>> in use, and have to be able to find the key in memory, but they already
>> can do both if they're root, and non-root can't [shouldn't be able to]
>> read swap devices on a properly secured machine.  Swap isn't meant for
>> storage across reboots/remounts, which is the only reason I can think of
>> for using encrypted loopback.  Once it's mounted, unless you have to enter
>> the password for every write, or unless it locks after some period of
>> inactivity (locking swap and requiring the password to unlock it sounds
>> like a fun proposition when the vm needs to swap), it's insecure until
>> it's locked/unmounted again.  Unmounting swap in a running system isn't
>> typical behavior.

SV> It does prevent one means of recovering possibly security-critical
SV> information for attackers who do have physical access to the machine.

Hmmm, if you have PHYSICAL access to the machine, you can simply reboot and type 
"linux init=/bin/sh" and after it simply cat /etc/shadow and run John The Ripper....
Am i wrong?

SV> The obvious approach to me would to generate a random session key at
SV> boot time and use that for encrypting/decrypting swap pages.  If the
SV> machine is unplugged and the disk pulled out, then the swap area on that
SV> disk could not be recovered the attacker, who presumably is prevented by
SV> other security measures from gaining root on the machine before it's
SV> unplugged to try to get that session key out of the kernel.  I haven't
SV> studied this problem, though, so the real solution may be quite a bit
SV> more clever.
SV> -
SV> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
SV> the body of a message to majordomo@vger.kernel.org
SV> More majordomo info at  http://vger.kernel.org/majordomo-info.html
SV> Please read the FAQ at  http://www.tux.org/lkml/

---
WBR. //s0mbre
