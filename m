Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUL0OgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUL0OgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 09:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbUL0OgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 09:36:23 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:24494 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261451AbUL0OgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 09:36:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Linux 2.6.10-ac1
Date: Mon, 27 Dec 2004 15:36:29 +0100
User-Agent: KMail/1.7.1
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
In-Reply-To: <41CF649E.20409@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412271536.29783.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 27 of December 2004 02:25, Andreas Steinmetz wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > What do you need 'serialize' option for?
> 
> I didn't check if the problem is gone with 2.6.10 but there's boards 
> like my tyan 2885 which do need the serialize option to work properly 
> for add-on ide controllers.
> 
>  From the X86-64 patch release notes of Andi Kleen:
> 
> Reports that dual Tyan S2885 and S2880 can lock up when multiple IDE 
> channels are stressed in parallel. "noapic" or "ideX=serialize" seems to 
> work around it. Andre Hedrick thinks it's a generic bug/race in the IDE 
> code.

Well, that's not the only case, I think.  I am able to lock up an S2885-based 
box by ripping audio CDs.  The CDs go into /dev/hda, which is a LiteOn 
DVD-ROM and the target is on /dev/sdb*, which is on a 3ware SATA RAID 
controller.  The machine locks up on one CD out of three (approx. 10 tracks 
each), quite regularly (I use KAudioCreator).  It does not lock up this way 
in any other conditions, apparently.

> Do you want to force people to disable the io-apic just because of 
> option removal? In my case the serialized devices are a disk and a 
> dvd-rw which is rarely used, so disabling the io-apic is a bad solution.

AFAIK, you can't disable the io-apic on these boards.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
