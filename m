Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRHPOgt>; Thu, 16 Aug 2001 10:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271348AbRHPOgk>; Thu, 16 Aug 2001 10:36:40 -0400
Received: from proton.llumc.edu ([143.197.200.1]:8625 "EHLO proton.llumc.edu")
	by vger.kernel.org with ESMTP id <S271367AbRHPOga>;
	Thu, 16 Aug 2001 10:36:30 -0400
From: "Don Krause" <dkrause@optivus.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
Date: Tue, 14 Aug 2001 09:07:08 -0700
Message-ID: <005c01c124db$2bf30870$6cc8c58f@satoy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <E15WcZ9-0000zr-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2 new systems with eepro 100's on the MB, and each one has that
problem with the eepro100 driver. Switching to the e100 module has solved
all issues with that card.

Both of these machines are Pogo linux rack mount units, and Pogo's default
RH 7.1 install is using the e100 driver also. For grins, I swithed those
boxes to the eepro100, and both lost their network connections within a few
hours if lightly loaded, and they lost it just a few minutes into large
(>100 meg) file transfers. Ftp or NFS, it didn't matter. (The kernel kept
running, the console was usable. Unloading the eepro100 didn't work,
however, the machine needed a power off reboot to get the net back)

After reinstalling RH 7.1 on both machines, and changing the detected
eepro100 driver back to the e100, the machines have not crashed since they
were put into service, some 20 days ago.

FWIW, one Pogo box has an Intel i810 MB, with onboard eepro100 eth, and an
additional pci intel nic, the other is a Tyan Thunder LE S2510, with a pair
of onboard nics.

--
Don Krause                                       ph: 909.799.8327
Systems Administrator                          page: 909.512.0174
Optivus Technology, Inc               e-mail: dkrause@optivus.com
"Splitting Atoms.. Saving Lives"           http://www.optivus.com


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
> Sent: Tuesday, August 14, 2001 4:41 AM
> To: Ime Smits
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
>
>
> > Funny things in syslog include:
> > kernel: mtrr: base(0xe8000000) is not aligned on a
> > size(0x4b0000) boundary
>
> Thats
> ok
>
> > kernel: eepro100: wait_for_cmd_done timeout!
>
> Those are not so good. I was having similar problems on an
> i810 box with
> onboard eepro100 until I disabled the pm stuff in 2.4.8ac2, but you
> seem to be running that one
>
> Alan

