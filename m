Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270110AbRHGGya>; Tue, 7 Aug 2001 02:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270111AbRHGGyO>; Tue, 7 Aug 2001 02:54:14 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:7117 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S270110AbRHGGyI>;
	Tue, 7 Aug 2001 02:54:08 -0400
Message-Id: <200108070654.f776sOl25211@www.2ka.mipt.ru>
Date: Tue, 7 Aug 2001 10:57:03 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: Crutcher Dunnavant <crutcher@datastacks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <20010807024101.B2399@mueller.datastacks.com>
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain> <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net> <200108070624.f776Ofl21096@www.2ka.mipt.ru>
	<20010807024101.B2399@mueller.datastacks.com>
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac7; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Tue, 7 Aug 2001 02:41:01 -0400
Crutcher Dunnavant <crutcher@datastacks.com> wrote:

CD> ++ 07/08/01 10:27 +0400 - John Polyakov:
>> Hello.
>> 
>> On Mon, 6 Aug 2001 22:55:19 -0700 (PDT)
>> Ryan Mack <rmack@mackman.net> wrote:
>> 
>> RM> Apparently some of you have missed the point.  Currently, the only way
>> to
>> RM> write any form of encryption application is to have it run setuid root
>> so
>> RM> it can lock pages in RAM.  Otherwise, files (or keys) that are
>> encrypted
>> RM> on disk may be left in an unencrypted state on swap, allowing for
>> RM> potential recovery by anyone with hardware access.  Encrypted swap
>> makes
>> RM> locking pages unnecessary, which relieves many sysadmins from the
>> anxiety
>> RM> of having yet-another-setuid application installed on their server in
>> RM> addition to freeing up additional pages to be swapped.
>> 
>> Hmmm, let us suppose, that i copy your crypted partition per bit to my
>> disk.
>> After it I will disassemble your decrypt programm and will find a key....
>> 
>> In any case, if anyone have crypted data, he MUST decrypt them.
>> And for it he MUST have some key.
>> If this is a software key, it MUST NOT be encrypted( it's obviously,
>> becouse in other case, what will decrypt this key?) and anyone, who have
>> PHYSICAL access to the machine, can get this key.
>> Am I wrong?

CD> Yes, you are wrong. The encryption key for the swap space can be created
CD> at boot time. We can wait for the hardware to give us enough entropy
CD> into the random number gen, and make a key. Then we mount the swap
CD> space, and all reads/writes go through that key. But the key is never
CD> recorded. The swap data is gone, even to legitimate users of the system,
CD> after a reboot.

And what program will access to timer or any other clock or any other hardware?
What programm will generate this key?
This program and key generation algorithm can not be encrypted.
Yes?
If this is true, we read this one and generate our key.
Am wrong again?

P.S. We don't look at the e-cards and other removable devices, isn't it?

CD> It is thus perfectly reasonable to wish to encrypt swap. In addition,
CD> there are good reasons to move in the direction of a non-All-Powerful
CD> root user. This is what the work in capabilities begins to approach.
CD> So simply waving your hands and saying that root can see it, so what
CD> does it matter, is not a long term solution to the problem.

CD> Crutcher        <crutcher@datastacks.com>
CD> GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
CD> R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

---
WBR. //s0mbre
