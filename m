Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131969AbQLZUHu>; Tue, 26 Dec 2000 15:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131992AbQLZUHk>; Tue, 26 Dec 2000 15:07:40 -0500
Received: from [209.143.110.29] ([209.143.110.29]:4612 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S131969AbQLZUHW>; Tue, 26 Dec 2000 15:07:22 -0500
Message-ID: <3A48F365.BBBAEDB6@the-rileys.net>
Date: Tue, 26 Dec 2000 14:37:09 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marvin Stodolsky <stodolsk@rcn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BIOS problem, pro Microsoft, anti other OS
In-Reply-To: <3A4769AC.F38B372C@rcn.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Stodolsky wrote:
> 
> To Maintainer:
> PCI SUBSYSTEM
> P:      Martin Mares
> M:      mj@suse.cz
> L:      linux-kernel@vger.kernel.org
> S:      Supported
> 
> This alert should probably be forwarded to Others, but appropriate
> subTask persons in the kernel-source Maintainers list were not obvious.
> 
> Briefly, documented below is the fact/complications that some PC BIOS
> chips are now coming with a default Microsoft setting, which makes them
> hostile to some functionalities of other OS.  If particular under Linux,
> a PCI Winmodem did NOT function with the Win98 BIOS setting, but did
> fine  with BIOS choice "Other OS".  Possible, other PCI devices under
> Linux OS might be simmilarly afflicated.
> 
> This indicates a need for Linux install software to be equipped with a
> utility to probe the BIOS and report back "Linux hostile" BIOS
> settings.  Today most Newbies are getting new PC boxes equipped with
> WinModems.  Hostile BIOS settings will block their capability to get
> on-line.  Unfortunately, I do not have the technical capablity to
> directly contribute.  Thus please forward this alert to however may be
> capable and concerned with dealing with the problem.
> 
> MarvS, co-maintainer: http://walbran.org/sean/linux/linmodem-howto.html
> 
> ===========================================
> Subject:  Device or resource busy : SUCCESS !
>      Date: Sun, 24 Dec 2000 14:46:04 +0200 (IST)
>     From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
>  Reply-To:  Jacques Goldberg <Jacques.Goldberg@cern.ch>
>        To: discuss@linmodems.org
> 
>  Well, my very sincere thanks to all of you. It works.
> 
> DETAILS:
> I purchased a Gateway Solo 2550 in September, comes with ActionTec PCI
> 56k
> modem (Lucent chip vendor 11c1, device 448).
> I tried the 568 ltmodem: device or resource busy,could not guess why.
> cat /pro/pci would show no interrupt
> Then ltmodem 578  was made available: same problem.
> But then the PnP issue at boot came again last week.
> I had tried several times to discover the option in my BIOS setup.
> This morning I found: in the "advanced" page there is an "Operating
> System" option, to be set to "the most frequently used OS". I had left
> it
> as Win98/2000 (as I received the machine).
> I just selected OTHER.
> Lo and behold, ltmodem.o loads without a flaw, I then had a short dumb
> terminal session with minicom, and am now connected at my first attempt
> with ppp, having already used X11, ssh, and Netscape.
> 
> So, again my deepest thanks to all of you on this list, and the bottom
> line for newcomers:
> 
>  IF (Device.or.resource busy) CHECK YOUR BIOS.
> 
> By the way I am running RH-6.1, kernel 2.2.12-20 (CERN "official" Linux
> distribution). They are on vacations now, I cannot check at this time if
> their version of ppp is "generic" or reworked.
> 
>                                 Jacques J. Goldberg
>                                 Jacques.Goldberg@cern.ch
>                                 >>>> Currently at TECHNION <<<<
>                                 PHONE: Technion=+(972)(0)(4)829.36.63
>                                            CERN=+(41)(22)767.84.72
>  -------- Original Message --------
> Subject: Crippling BIOSes
> Date: Sun, 24 Dec 2000 14:55:36 -0500
> From: Marvin Stodolsky <stodolsk@rcn.com>
> To: LinModems <discuss@linmodems.org>
> 
> Folks,
>         Given Jacques report, it would be good to set up a
> diagnostic for BIOS which have such Microsoft/Other choices.
> Mine does not.
> For those of you who have such BIOSes, please
> 1) Do  boots under both choices
> 2) Under microsoft do:
>   dmesg > ms.txt
> 3) Under other
>    dmesg > other.txt
> 4) diff ms.txt other.txt
> and report the differences to the List with the name of the BIOS.
> If would clearly be desirable to equip future Linux kernels/software to
> give a warning about the crippling microsoft option,
> which may hamper other PCI harware under Linux as well.
> 
> MarvS
> 
> -------- Original Message --------
> Subject:   Re: dmesg detection??
>      Date:   Mon, 25 Dec 2000 09:29:20 +0200 (IST)
>     From:    Jacques Goldberg <goldberg@phep2.technion.ac.il>
>  Reply-To:   Jacques Goldberg <Jacques.Goldberg@cern.ch>
>        To:   Marvin Stodolsky <stodolsk@rcn.com>
>       CC:    discuss@linmodem.org
> 
>  Gateway Solo 2150
>  Phoenix BIOS version 17.50
>  BIOS Page "Advanced"
>  BIOS Field "Installed O/S" may be "Other" "Win98/Win2000" or "Win95"
>  Did not try "Win95"
>  Default was Win98/Win2000, dmesg file attached is  ms.txt
>  Changed to "Other" , dmesg file atached is  other.txt
> 
>  Linux kernel 2.2.12-20
> 
>  SOUND:
>   CONFIG_SOUND set to "m"
>   Using OSS driver (ES-1371 not supported by RH-6.1  2.2.12-20
> distribution)
>   Using PPP version 2.3.10-3
> 
>  Everything works fine (ppp sessions with sound) once BIOS O/S choice
> set
> to OTHER.
> 
>  I repeat what my problem was:
>  -could not load ltmodem : "Device or resource busy"
>  -cat /pro/pci did not show IRQ, not even the word IRQ, for Lucent modem
>  -setting BIOS to OTHER instantly made everything work.

I don't think this can necessarily be classified as "Linux hostile", but
really more as "Linux ignorant".  In most decent BIOS setups, the
"Windows" option in your setup would read as "PnP OS".  The writers of
your bios just assumed that Windows is the only OS that works properly
with PNP (though up until recently that wasn't far from the truth).

In any case, using a somewhat newer kernel (like 2.4.0-test12, I think)
should solve problems by properly handling PnP stuff.

Thanks,
	David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
