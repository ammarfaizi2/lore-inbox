Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271137AbRHOLEs>; Wed, 15 Aug 2001 07:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271136AbRHOLE2>; Wed, 15 Aug 2001 07:04:28 -0400
Received: from MailAndNews.com ([199.29.68.123]:36368 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S271135AbRHOLES>;
	Wed, 15 Aug 2001 07:04:18 -0400
X-WM-Posted-At: MailAndNews.com; Wed, 15 Aug 01 07:03:55 -0400
Message-ID: <009101c12579$ba4d8e80$c405a33e@brekoo.noip.com>
From: "Marc Brekoo" <m_brekoo@mailandnews.com>
To: "dlang" <dlang@enabledparadigm.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108142226220.5310-400000@web.lang.hm>
Subject: Re: lockup problem with 2.4.5,8 athlon
Date: Wed, 15 Aug 2001 13:02:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe you should try to enable CONFIG_M686 instead of CONFIG_K7.
(Menuconfig -> Processor-setup). It works for me, I don't get those lockups
anymore.

Regards,
Marc Brekoo.

----- Original Message -----
From: "dlang" <dlang@enabledparadigm.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, August 15, 2001 7:26 AM
Subject: lockup problem with 2.4.5,8 athlon


> I have been fighting a problem with 2.4.5 for a little while, I just
> installed 2.4.8 onto these boxes and can still get them to lock up within
> an hour.
>
> I have multiple athlon servers that I can get to lockup at will.
>
> these servers are MSI motherboards, 512MB ram PC133, ATA100 20G hard
> drives. 1.2GHz t-bird, D-link quad fast ethernet.
>
> when they lock up I cannot ping the box, the screen is blank (does not
> reapond to alt-sysrq), keyboard numlock does not respond, the reset button
> does not work and the power switch needs to be held down for 4 sec to shut
> off power. Nothing appears in syslog (no messages at all between boot and
> lockup, except for proxy logs in method 1).
>
> I have two ways I can get the box to die.
>
> method 1: over the network.
>
> I have the plug-gw proxy from the firewall toolkit installed. If I make
> sufficiant connections to the proxy rapidly enough the box will lock up.
>
> I started this test in an attempt to find out why the production box was
> slowing to a crawl after being in production for a while (under the same
> workload it was shifting from 5%user/10%system to 2.5%user/97.5% system
> and staying that way even if the load went away. A system reboot would
> clean things up for a day or so. In attempting to duplicate the problem I
> have been hammering the box with connections much more rapidly and the
> problem seems to appear faster if I hammer faster.
>
> the plug-gw does log heavily, with syslog configured for sync logging I
> max out at ~80 connections/sec with it set for async logging I get ~300
> connections/sec. in my latest test the log file grew to 39MB on an
> ext2fs with ~2100 lines of binary junk appended to the file between the
> last intact log message and the boot messages.
>
> method2: no network.
>
> I created a simple script
>
> #!/bin/bash
> while (true) do
> date >>junk.lots
> done
>
> I start 20 of these running at the same time and the box will die within
> an hour or so. I have seen the junk.lots file be ~70MB at the time of
> death, and at the last crash it is 64MB (contains the last two crashes,
> and ~1200 lines of garbage that look like they are part of a syslog file
> from Aug 2)
>
> On both machines I have gone into the BIOS and set 'failsafe defaults'.
> this helped lengthen the time between crashes (before I could sometimes
> get the machines to crash just by letting them sit idle for several
> hours).
>
> attached is the .config used to build the kernel and the lspci -vxx from
> each of the two machiness.
>
> please tell me what I can do to assist in debugging this problem.
>
> David Lang
>
>
>

