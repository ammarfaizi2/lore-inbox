Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSH0WSq>; Tue, 27 Aug 2002 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSH0WSp>; Tue, 27 Aug 2002 18:18:45 -0400
Received: from [212.112.174.180] ([212.112.174.180]:40591 "EHLO prometheus")
	by vger.kernel.org with ESMTP id <S315491AbSH0WSo>;
	Tue, 27 Aug 2002 18:18:44 -0400
Date: Wed, 28 Aug 2002 01:23:01 +0200
From: Peter Schuller <peter.schuller@infidyne.com>
To: linux-kernel@vger.kernel.org
Subject: 53c1010 controller / LF-D200 DVD-RAM causes system lag
Message-ID: <20020827232301.GA3181@prometheus.scode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been experiencing some annoying behavior with an LF-D200 DVD-RAM
on my Tekram SCSI controller (SYM53c1010 chipset). I have tried all I
can think of except different combinations or hardware which I don't
have available. I have been unable to find any information this issues
when searching the web.

Problem: During heavy access, the entire system becomes "lagged". System
CPU usage goes up (load skyrockets); keypresses and keyreleases are
missed (missed interrupts?). This happens mostly in bursts, although
key events are missed constantly when this happens.

The problem is most pronounced when accessing a filesystem on the
DVD-RAM; but also present when writing data to the device directly.

It does not always happen. I can write a few megs with no problem. Even
tens or hundreds of megs. My best guess at the moment is that I start
seeing problems when the fs cache fills up and it flushes data to the
disk. It does *not* consistently occur when sync:ing though (i.e. I can
write, say, 10 meg and do a sync without any noticable problems).

Also, as far as I know (but I am not certain) I can write any amount
of data to the disk without problems while sync:ing once every 10
seconds or so - assuming the input is coming in more slowly than the
speed of the DVD-RAM. I have not experimented a lot with this, but
it was my initial observation when writing a tarball to the drive
through netcat.

I have tried a few different kernels; most recently 2.4.19. I have tried
both version 1 and 2 of the sym53c8xx driver.

I have a number of SCSI disks, one CD-ROM and one CD-burner on the
controller. None of them exhibit any of these problems; it's just the
DVD-RAM.

The drive shows up as a CD-ROM device (/dev/scd*), and NOT as a regular
disk (/dev/sd*). Wheather this is correct I do not know; but I do know
that at least some other DVD-RAM:s show up as disks (based on what I've
read in HOWTOs).

As far as I have been able to tell I do not have any problems with
cabling, SCSI resets, etc. AFAIK the symptomes are not consistent with
such problems either. 

Could this be a kernel problem? If so, what can I do to help debug it?
What other information should I provide?

Thank you,

-- 
/ Peter Schuller, InfiDyne Technologies HB

PGP userID: 0xE9758B7D or 'Peter Schuller <peter.schuller@infidyne.com>'
Key retrival: Send an E-Mail to getpgpkey@scode.org
E-Mail: peter.schuller@infidyne.com Web: http://www.scode.org

