Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbRE1WUq>; Mon, 28 May 2001 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbRE1WUg>; Mon, 28 May 2001 18:20:36 -0400
Received: from [216.74.100.93] ([216.74.100.93]:3079 "EHLO
	host7.hrwebservices.net") by vger.kernel.org with ESMTP
	id <S263172AbRE1WU3>; Mon, 28 May 2001 18:20:29 -0400
Message-ID: <001301c0e80f$f898f0a0$c1a5fea9@spunky>
Reply-To: <james@spunkysoftware.com>
From: <james@spunkysoftware.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E154UTa-0003YH-00@the-village.bc.nu>
Subject: Re: Creative 4-speed CDROM driver
Date: Tue, 29 May 2001 08:20:42 +0100
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

Can you explain what this meas? Fake an SCSI device and use the SCSI driver
to drive my CDROM? But what about the I/O port regions of memory, and the
IRQ? Aren't they different?

I am new to device drivers, I don't understand what I have to do. I know
that I need to provide a service so I can mount my cdrom and use it, and
that applications can read data from the /dev/cd0/whatever.file file on
Minix.

I need to know what the I/O hex memory area is, what IRQ to use, etc. I also
need to know what functions I have to provide, like:

open(filename, mode)
read(fd, buffer, buffersize, flags) -- how to specify number of byts to
read??

In the device driver code, I need to know what commands are for the ATAPI
CDROM, or how I can do it as an SCSI like you say, like 0x30 put in I/O
address whatever might be to query to see if there is a CD in the drive etc
etc.

This is very confusing. Would I benefit from reading the standards document
you speak of? Where can I download a copy?

How do I handle asynchronous I/O with a driver for a CDROM? Do I identify
each user by the file descriptor when they issue a open() call, like in
subsequent calls to read() they will pass the file descriptor, and I would
have say a list of structures holding the file descriptor, offset where the
last read() was, and so on, if so, what fields do I put in my structures and
so on?

As you can see, I am a newbie to device driver writing. ;) I am trying to
learn by doing.

Unfortunately, I simply do not understand the code for device drivers that
hackers have written. I don't know where to start and how to make sense of
the code, to read it line by line and understand what it is doing.

I am going to take a look at the IDE CDROM driver code in Linux and see if I
can modify the code to work as a device driver for Minix.

Hope you can help me here, I'm really stuck!

:-) Thanks Alan. I see that you are a prominent Linux developer and you know
Linus. What device drivers have you written, or do you concentrate on the
kernel proper?

Cheers mate!
James


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <james@spunkysoftware.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, May 28, 2001 10:22 PM
Subject: Re: Creative 4-speed CDROM driver


> > If anyone on the kernel list has written a driver for a CDROM please
send me
> > mail about how you went about it, did you approach the manufacturer for
the
> > documentation on the device, if I made a mistake could I ruin my
hardware?
> > and stuff like that.
>
> For IDE CD-ROM there is a standard. Its about 600 pages long but the best
> model is probably to implement scsi over atapi since Minix has some basic
scsi
> code. Then you can drive all but very old ide cdrom devices as scsi
>
>
>

