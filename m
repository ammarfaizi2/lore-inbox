Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272275AbTGYTm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272276AbTGYTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:42:57 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:25606 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S272275AbTGYTmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:42:55 -0400
Date: Fri, 25 Jul 2003 21:57:52 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: cutting down on boot messages
Message-ID: <20030725195752.GA8107@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I boot my system, there are copious messages. 

For example:

md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdc6 ...
md:  adding hdc6 ...
md: hdc5 has different UUID to hdc6
md: hdc3 has different UUID to hdc6
md: hdc1 has different UUID to hdc6
md:  adding hda6 ...
md: hda5 has different UUID to hdc6
md: hda3 has different UUID to hdc6
md: hda1 has different UUID to hdc6
md: hdi2 has different UUID to hdc6
md: hdi1 has different UUID to hdc6
md: hde2 has different UUID to hdc6
md: hde1 has different UUID to hdc6
md: created md5
md: bind<hda6>
md: bind<hdc6>
md: running: <hdc6><hda6>
md5: setting max_sectors to 128, segment boundary to 32767
raid1: raid set md5 active with 2 out of 2 mirrors

Now these messages are often uninteresting - but sometimes they are.
So just deleting them, or requiring a recompile or reboot is not good
enough.
Also, I noted that these messages were almost always grouped together.

Suppose these messages were removed from the normal output, but instead
stored in a buffer in the kernel.

Then, you could do

dmesg.raid

to get at the raid-messages,

and 

dmesg.raid --clear 

to clear the buffer.

The same goes for other groups of messages, like the whole APIC/IRQ
routing block, ide messages, usb messages etc.

Would this keep the interesting information, but cut down on the amount
of messages? I'm now at 22k of dmesg, including raid, usb, apic etc, for
a single CPU system.

I'd be interested in everyone's opinion on this!

Jurriaan
-- 
REAL LIFE MANAGEMENT 'DILBERT QUOTATIONS':
11: One day my Boss asked me to submit a status report to him concerning a
    project I was working on. I asked him if tomorrow would be soon
    enough. He said "If I wanted it tomorrow, I would have waited until
    tomorrow to ask for it!" (New business manager, Hallmark Greeting
    Cards.)
Debian (Unstable) GNU/Linux 2.6.0-test1-ac2 4112 bogomips load av: 1.00 1.00 1.00
