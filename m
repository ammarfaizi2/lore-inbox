Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSAHI12>; Tue, 8 Jan 2002 03:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287972AbSAHI1S>; Tue, 8 Jan 2002 03:27:18 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:18756 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S287971AbSAHI1H>;
	Tue, 8 Jan 2002 03:27:07 -0500
Message-ID: <3C3AACE0.8030408@dplanet.ch>
Date: Tue, 08 Jan 2002 09:25:04 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leif Sawyer <lsawyer@gci.com>
CC: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] RE: CML2-2.0.0 is available -- major release announcement
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506DB462C@berkeley.gci.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2002 08:27:06.0437 (UTC) FILETIME=[41DA9750:01C1981E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer wrote:

> 
> Picked USB HCI's as modular (building all) from VIA motherboard.
> 	(Don't really need the OHCI built here)


This is a know problem. The problem is: we don't know yet

if a given USB configuration is a USB card, a USB kernel support
(i.e. USBFS, OHCI, EHCI...).
The solution is to modify the configuration rules, adding
the USB_CARDS (as Eric proposed for ISA_CARDS).
But this rules change can be done only after CML2 is included
into the kernel.

> Missed HOTPLUG (based on USB, and configure_help - this may just be cleanup
> 			in the help text to remove references to USB if
> hotplug
> 			is not needed/required)


Eric: Rule error ?

> 
> Missed APM support (is enabled in running kernel)


I know. I don't know if I should autodetect APM support.
On some machine APM crash the kernel and in some more
machine you must tune the APM options.

I'm not an APM expert, so I need some help.


> Missed my parallel port.

 > Missed my floppy drive!

I have some problem with these rules.
I should find a solution on how to detect
these on a x86 wihout breaking the other
archs.
Probably the best solution is to change the rules:
the floppy disk is linked to CONFIG_FLOPPY (or an
other non conflicting names) and the various archs
controller configuration is derives from FLOPPY
and ARCH_*.


> Missed SCSI_Generic
> Missed Unix Domain Sockets!
> Missed Packet Socket (based on running kernel)


Hard to detect these 'software devices'.
Some suggestions?

> Missed PS/2 mouse


hmm. I forgot these rules during the conversions.
[but ATARI PS/2 conflict with this]

	giacomo

