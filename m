Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTH2OBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbTH2OBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:01:14 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:35124 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S261214AbTH2OBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:01:10 -0400
Message-ID: <3F4F5C9A.5BAA1542@vtc.edu.hk>
Date: Fri, 29 Aug 2003 22:00:58 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble??
References: <3F4EA30C.CEA49F2F@vtc.edu.hk> <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

Alan Cox wrote:

> On Gwe, 2003-08-29 at 01:49, Nick Urbanik wrote:
> > Dear Folks,
> >
> > With a single 2.26GHz P4, an Asus P4B533-E motherboard, is it possible
> > to reliably use two additional PCI IDE cards (using SI680), one hard
> > disk per channel, and have the thing work reliably?
>
> You should be able to, although with software raid your PCI bandwidth
> limits will limit the ultimate performance for mirroring/raid

Performance is a relatively minor issue compared with stability and low
cost.

Is there _anyone_ who is using a number of ATA133 IDE disks (>=6), each on
its own IDE channel, on a number of PCI IDE cards, and doing so
successfully and reliably?  I begin to suspect not!  If so, please tell us
what motherboard, IDE cards you are using.  I used to imagine that a
terabyte of RAID storage on one P4 machine with ordinary cheap IDE cards
with software RAID would be feasible.  I believe it is not (although I
cannot afford to play musical motherboards).

> > My machine locks solid at unpredictable intervals with no response
> > from keyboard lights, no Alt-Sysrq-x response, etc, with a wide
> > variety of 2.4.x kernels, including 2.4.22.
>
> A freeze in an IRQ handler would cause that kind of thing, turning on
> the NMI watchdog might get you a trace in such a failure case - and
> that would help.

If the NMI count is positive in /proc/interrupts, and I have nmi_watchdog=2
in /proc/cmdline, does that mean that the NMI watchdog is turned on?  If
so, it never yielded anything: the machine also never responded to keyboard
lights, Alt-Sysrq-s, etc.  I have a serial terminal (minicom on an old 486
with a capture log running) as my console, since I want to catch the
culprit.  I always checked console output up to the lock up.
$ sudo grep -c 'syslogd 1.4.1: restart.' messages*
messages:13
messages.1:9
messages.2:4
messages.3:6
messages.4:4
That's a lot of locking up!
A careful look through the output of
$ sudo grep -B10 'syslogd 1.4.1: restart.' messages*
shows no output from the watchdog.

I am giving up now, and have shelled out big dollars for a 3ware 7506-8,
which I will install early next week once I've figured out how to back up
and restore 203GB without shelling out even more money.

I am honoured by your reply!   Have fun with the MBA.

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



