Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274794AbRIVK5C>; Sat, 22 Sep 2001 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274822AbRIVK4w>; Sat, 22 Sep 2001 06:56:52 -0400
Received: from oe31.law11.hotmail.com ([64.4.16.88]:45586 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S274794AbRIVK4n>;
	Sat, 22 Sep 2001 06:56:43 -0400
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>, "Greg Ward" <gward@python.net>
Cc: <bugs@linux-ide.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Date: Sat, 22 Sep 2001 03:53:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE3183UV8wAddX47sFo00001649@hotmail.com>
X-OriginalArrivalTime: 22 Sep 2001 10:57:03.0615 (UTC) FILETIME=[4FFA00F0:01C14355]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not an expert user, just someone who's been trying feeble-ly to get
Linux working for the past 3 months on my new computer.  I have a Promise
chip (PDC20265) and Via vt86c686b on my A7V133.  I get these DMA timeout
errors when I am even trying to install Linux!  I did manage to get Redhat
7.1 installed a few months ago, as well as Debian 2.2r3.  I'm not sure if
that was a fluke or not.  The only thing that I changed with my setup since
then that might have affected things, is that I upgraded the ASUS bios at
some point.  Anyways, at this point in time, no version of Linux will
install.  After the installer starts to install a few packages (sometimes
10, sometimes 100), the installer halts, the hard disk light stays on, and
if I use CTRL-ALT-F4, I see these DMA timeout errors.  The hard drive is
unresponsive unless I do a cold boot, as opossed to warm boot.

Sorry for broadcasting this across the linux kernel mailing list.  I can't
provide any lspci info., etc.. because I'm kind of new to Linux, and also,
this bug is not allowing me to install Linux period.  And BTW, Windows runs
with no problems on both IDE controllers, so I know it's not my PC.  I know
lots of people who have gotten this motherboard and similar motherboards to
work.  But I can't, and since I am just an everyday user who is trying to
run Linux on my PC, I think these bugs are important to fix.  Or at least it
needs to be made public knowledge what someone like me needs to do to get it
working.  (Although I'm not blaming anyone working on the kernel.  I can
only blame the people at Via and Promise for only been semi-cooperative with
kernel development at best).

David Grant

----- Original Message -----
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: "Greg Ward" <gward@python.net>
Cc: <bugs@linux-ide.org>; <linux-kernel@vger.kernel.org>
Sent: Saturday, September 22, 2001 1:04 AM
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour


> On Fri, Sep 21, 2001 at 04:43:04PM -0400, Greg Ward wrote:
> > On 21 September 2001, Vojtech Pavlik said:
> > > There were updates in 2.4.9-pre2 in the VIA driver, so it might be
worth
> > > trying. Also disabling CONFIG_IDEDMA_AUTO may work, but you'll get
slow
> > > performance.
> >
> > OK, I've just rebooted with CONFIG_IDEDMA_AUTO not set.  Same thing
> > happens; kernel prints "hde: timeout waiting for DMA" at boot time,
> > "hdparm /dev/hde" reports DMA on, and "dd if=/dev/hde of=/dev/null
> > count=1" takes about 20 sec to complete.  (Hmmm: in previous builds,
> > the kernel would turn DMA off for me after that long DMA timeout delay.
> > It no longer does so.  If I "hdparm -d0 /dev/hde", then there's no
> > long delay on read.)
> >

