Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280863AbRKOOwz>; Thu, 15 Nov 2001 09:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280867AbRKOOwq>; Thu, 15 Nov 2001 09:52:46 -0500
Received: from ivy.tec.in.us ([168.91.1.1]:13702 "EHLO otter.ivy.tec.in.us")
	by vger.kernel.org with ESMTP id <S280863AbRKOOwi>;
	Thu, 15 Nov 2001 09:52:38 -0500
Message-ID: <4687.168.91.2.45.1005835548.squirrel@mail.ivy.tec.in.us>
Date: Thu, 15 Nov 2001 09:45:48 -0500 (EST)
Subject: Re: 2.4.14 reboot on/before boot
From: "John Madden" <jmadden@ivy.tec.in.us>
To: <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E1649VZ-0006K9-00@the-village.bc.nu>
In-Reply-To: <E1649VZ-0006K9-00@the-village.bc.nu>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Two machines, identical hardware (Dell 2450's, Dual PIII/667, 1gig
>> ram). One one, 2.4.14 boots and runs nicely, as one would expect.  On
>> the other, "as close to exact as I can imagine" compile configs, the
>> machine reboots just after LILO's "Loading Linux..."  Same version of
>> LILO on both as well.
>>
>> Has anyone else experienced this?  Any ideas on a fix?
>
> Check they are the same BIOS. If so run memtest86 across them. The Lilo
> load/unpack might be enough to stress memory and find real faults

Checked the BIOS versions and memtested the 'bad' machine, versions match,
no bad memory found.

I tried upgrading on multiple machines, some others failed, some didn't.  So
far, two of our 2450's take 2.4.14 without issue and three don't.

Working:
Dual PIII/667, 1gig, 3x18gb scsi, adaptec 7xxx
Dual PIII/1000, 1gig, 4x18gb scsi, ami megaraid

Not working:
Single PIII/667, 256mb, 2x18gb scsi, adaptec 7xxx
2 x (Dual PIII/667, 1gig, 3x18gb scsi, adaptec 7xxx)

All 5 machines have the same BIOS and 'backplane' rev.

In the 'not working' machines, all three do exactly the same thing: LILO ->
"Loading Linux.." (or something similar, text that flashes very quickly) ->
reboot.  All of these boxes have and are running 2.2.19 without so much as a
single crash (or any other issue, for that matter) since upgrading from
2.2.16.  I can swallow one machine having a fluky RAM issue, but not three.

I'm strongly considering dropping back to 2.2.20...

Thanks,
  John




-- 
John Madden
UNIX Systems Engineer
Ivy Tech State College
jmadden@ivy.tec.in.us



