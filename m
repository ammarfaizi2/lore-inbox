Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSBLPOa>; Tue, 12 Feb 2002 10:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291103AbSBLPOV>; Tue, 12 Feb 2002 10:14:21 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S291102AbSBLPOP>;
	Tue, 12 Feb 2002 10:14:15 -0500
Message-ID: <003f01c1b3d7$fd1755b0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "George Bonser" <george@gator.com>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0202120950480.12840-100000@vervain.sonytel.be>
Subject: Re: Linux console at boot
Date: Tue, 12 Feb 2002 10:14:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "George Bonser" <george@gator.com>
Cc: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 12, 2002 3:52 AM
Subject: Re: Linux console at boot


> On Thu, 24 Jan 2002, George Bonser wrote:
> > Is there any way to stop the console scrolling during boot? My reason
> > for this is I am trying to troubleshoot a boot problem with
> > 2.4.18-pre7 and I would like to give a more useful report than "it
> > won't boot" but the screen outputs information every few seconds and I
> > can't "freeze" the display so I can copy down the initial error(s).
> >
> > This is an Intel unit using the standard console (not serial console).
> > pre7 will not boot but pre6 boots every time.
>
> On Amiga (m68k and PPC) we have a `debug=mem' option that will write all
kernel
> messages to a 256 KiB block (marked with a magic number) of Chip RAM. If
the
> system crashes early, you can reboot into AmigaOS and run a special
utility
> that finds the 256 KiB block (Chip RAM is not completely erased on reboot)
and
> extracts the messages.

Also, printk already writes (appends) to a smaller-but-sufficiently-large
buffer - log_buf.  When debugging early boot crashes, I frequently look up
the address of log_buf in System.map and dump that area of memory from my
boot monitor or JTAG prompt.

Regards,
Brad

