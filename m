Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280041AbRKITZ7>; Fri, 9 Nov 2001 14:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKITZt>; Fri, 9 Nov 2001 14:25:49 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:4114 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S280033AbRKITZn>;
	Fri, 9 Nov 2001 14:25:43 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: serial console slow
Date: Fri, 9 Nov 2001 19:25:42 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9shajm$7eo$5@ncc1701.cistron.net>
In-Reply-To: <20011109102140.A29288@elf.ucw.cz> <9sha2j$l5l$1@cesium.transmeta.com>
X-Trace: ncc1701.cistron.net 1005333942 7640 195.64.65.67 (9 Nov 2001 19:25:42 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9sha2j$l5l$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>I have had much better luck talking to /dev/console in userland.
>IMNSHO this should *always* work; anything else is broken.
>/dev/console currently *IS* broken to some degree, multi-console
>hasn't worked properly for a long time, and you don't get job control
>running of it because it isn't a tty, but I think it's a lot less
>broken than things like the above...

You don't have job control on /dev/console because it will never
become a controlling tty automatically. But if you make it your
controlling tty with the right ioctl() you'll have job control.

In fact the latest sysvinit does this for process spawned from
the 'sysinit', 'bootwait' and 'wait' type lines in /etc/inittab
and that works fine.

>(And dammit, I really would like to see console=tty0 console=ttyS0 to
>actually give me both consoles -- in userland *and* in the kernel...)

That would be extremely c00l ;)

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

