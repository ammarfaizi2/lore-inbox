Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157358-27300>; Sat, 30 Jan 1999 19:08:07 -0500
Received: by vger.rutgers.edu id <157212-27300>; Sat, 30 Jan 1999 19:07:50 -0500
Received: from jeremiah.sunshinecomputing.com ([207.114.150.75]:1140 "EHLO job.sunshinecomputing.com" ident: "root") by vger.rutgers.edu with ESMTP id <157272-27300>; Sat, 30 Jan 1999 19:05:57 -0500
Message-ID: <010801be4cb0$36745020$499672cf@sunshinecomputing.com>
From: "Brian Macy" <bmacy@sunshinecomputing.com>
To: "Greg Zornetzer" <gaz@andrew.cmu.edu>
Cc: <linux-kernel@vger.rutgers.edu>
Subject: Re: I want kerneld back..
Date: Sat, 30 Jan 1999 16:25:31 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.0810.800
Sender: owner-linux-kernel@vger.rutgers.edu

Actually I discovered the problem just about an hour after my post. I looked
*really* close at RedHat's rc.sysinit script which appeared to be setup
properly for handling kmod versus kerneld. Basically what was broke was that
it wasn't running depmod -a on startup if kmod was enabled though it would
do everything else correctly. Since changing that worked I assume depmod
should be run at startup.

Brian Macy

----- Original Message -----
From: Greg Zornetzer <gaz@andrew.cmu.edu>
To: Brian Macy <bmacy@sunshinecomputing.com>
Cc: <linux-kernel@vger.rutgers.edu>
Sent: Saturday, January 30, 1999 1:31 PM
Subject: Re: I want kerneld back..


>Hi Brian,
>
>On Sat, 30 Jan 1999, Brian Macy wrote:
>
>> Actually I just want kmod to work. I've mentioned this since I started
using
>> 2.1.12? but all I get is read the FAQs/ChangeLog/kmod.txt. I have... it
>> don't help.
>>
>>  The best I've gotten kmod to do is *if* I build SCSI support as a module
>> and insmod scsi_mod manually in rc.local, It will load the tape, cdrom,
and
>> initio drivers automatically when accessed. I can't get it to work at all
>> with eth0/eth1 and when I compiled SCSI support into the kernel the tape,
>> cdrom, and initio drivers would no longer autoload.
>>
>> Please help... I've been using modules (especially for ethernet and SCSI)
>> for years without problems but the 2.1.1* through 2.2.1 kernels have just
>> got me beat.
>Do you have any error messages?  What happens when you try to load the
>SCSI support.  If no modules are loaded, you really should be seeing in
>the syslog something to the effect of "Module xxxx could not be loaded".
>While I don't have modular SCSI on any of my systems, I do have module
>support compiled for SCSI cdroms, and generic SCSI access, and these seem
>to work smoothly.  I'm truly surprised that autoloading of ethernet
>modules fails - again, can we see some clips of the syslog?  Also, can we
>see a copy of your /etc/conf.modules (or modules.conf, which ever one you
>use).  These will be helpful in tracking down your problems.
>
>>
>> I'm using modutils-2.1.121, kerneld is not running, echo "/sbin/modprobe"
>
>> /proc/sys/kernel/modprobe is being done, kmod is built into the kernel,
>> conf.modules doesn't need to change (at least from what I've read).
>Looks like you're up to date, WRT the packages.
>
>>
>> Brian Macy
>
>Greg Zornetzer - gaz+@andrew.cmu.edu
>"Light shines brightest in the darkest night"
>http://www.contrib.andrew.cmu.edu/~gaz
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.rutgers.edu
>Please read the FAQ at http://www.tux.org/lkml/
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
