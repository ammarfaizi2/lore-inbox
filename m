Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154838AbPIARPl>; Wed, 1 Sep 1999 13:15:41 -0400
Received: by vger.rutgers.edu id <S154811AbPIAROX>; Wed, 1 Sep 1999 13:14:23 -0400
Received: from mailext12.compaq.com ([207.18.199.188]:47679 "HELO mailext12.compaq.com") by vger.rutgers.edu with SMTP id <S154533AbPIARN5>; Wed, 1 Sep 1999 13:13:57 -0400
Message-ID: <XFMail.990901103912.brianw.hall@compaq.com>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 01 Sep 1999 10:39:12 -0600 (MDT)
Reply-To: Brian Hall <brianw.hall@compaq.com>
Organization: Compaq
From: Brian Hall <brianw.hall@compaq.com>
To: willy@meta-x.org, x-linux-kernel@vger.rutgers.edu
Subject: kmsgdump-0.3.1 and kernel 2.2.12
Sender: owner-linux-kernel@vger.rutgers.edu

I am currently working on a crash dump processing tool, so I have been very
interested in your kmsgdump patch. I have applied it against the 2.2.12 kernel,
and it works fine if invoked manually. Since my main interest was the automatic
mode, I tried that. Basically the automatic mode doesn't work for me. System is
RedHat 6/Intel.

I have created two kernel modules, one to cause a recoverable oops, and one to
force a panic. Invoking those two in sequence causes the automatic dump
sequence to trigger, but only garbage is written(?) to the floppy (drive light
never comes on like it does when I invoke the dump manually). I am using the FAT
format and automatic reboot options. Also, I get an error written to the console
exactly when I think it should start writing to the floppy: 

Unable to handle kernel paging request at virtual address 3cc01987 

of course the address varies. Doesn't seem to cause an oops (only oopses in
the log are from insmod'ding my modules). I'm not sure if this is a problem with
kmsgdump or the way I am trying to trigger it. Do you have a good method of
triggering automatic operation?

I set the delay to 30 seconds, and did my method for trigging the autodump.
Before the timer reached 30 seconds, I did a manual dump. This did not give the
error message, and appeared to work (drive light came on), but there was only
garbage in the messages.txt file.

One other comment I have is about the floppy format. Years ago when I used
OS/2, there was a floppy formatting program that formatted the floppy with a
standard FAT filesystem, but modified the boot block in such a way that if the
system tried to boot from the floppy, control would be transferred to the hard
drive. This worked very well for accidentally leaving a floppy in the drive on
a reboot. I would suggest doing this to the kmsgdump floppies, so that the disk
can be left in the drive all the time, and any data written to it could be
processed automatically, i.e. by the tool I'm working on ;-) .

--
Brian Hall <brianw.hall@compaq.com>
Linux Consultant

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
