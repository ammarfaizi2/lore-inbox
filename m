Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281702AbRKUKna>; Wed, 21 Nov 2001 05:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKUKnU>; Wed, 21 Nov 2001 05:43:20 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:48646 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S281563AbRKUKnQ>;
	Wed, 21 Nov 2001 05:43:16 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: New ac patch???
Date: Wed, 21 Nov 2001 10:43:15 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9tg0g3$jbl$1@ncc1701.cistron.net>
In-Reply-To: <20011121100849.D15851@joshua.mesa.nl> <E166TZh-0004T8-00@the-village.bc.nu>
X-Trace: ncc1701.cistron.net 1006339395 19829 195.64.65.67 (21 Nov 2001 10:43:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E166TZh-0004T8-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> 2.4.13-ac will "flushing ide drives" on shutdown. This helped my laptop
>> from not '/dev/hdax no cleanly unmounted, checking' on startup. I'm sure
>> the system did not crash before that.
>
>You have a box with an IBM 20Gig 2.5" drive (just out of interest)
>
>> 2.4.15-pre6 does not have this code and now sometimes some filesystems
>> seem not to be clean anymore on startup...
>> Will the ide_notify_reboot be included in 2.4.15 final?
>
>Probably not - the taskfile/LBA48 code wants more testing first. I believe
>you can pick up the relevant patch from www.linux-ide.org however, thanks
>to Andre

As I posted here last week, it's trivial to put the IDE drives into
standby mode just before powerdown instead. It has the same effect
and it would take just a few lines of code.

The Debian /sbin/halt does this now just before it asks the kernel
to poweroff, and it fixes this problem just fine. It would be better
if the kernel did it though.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

