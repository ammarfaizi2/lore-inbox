Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSGBNHo>; Tue, 2 Jul 2002 09:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSGBNHn>; Tue, 2 Jul 2002 09:07:43 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:22276 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316775AbSGBNHl>; Tue, 2 Jul 2002 09:07:41 -0400
Date: Tue, 2 Jul 2002 06:10:04 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI Cards ?!?!?
Message-ID: <20020702061004.A16876@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20020702222604.00b1f1a0@mail.off.ournet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <5.1.0.14.2.20020702222604.00b1f1a0@mail.off.ournet.com.au>; from darryl@harvey.net.au on Tue, Jul 02, 2002 at 10:26:12PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 10:26:12PM +1000, Darryl Harvey wrote:
> 
> I am using an Initio 9100UW and it is giving me nothing but grief.
> 
> 
> bash-2.05a# cat /proc/scsi/INI9100U/0
> The driver does not yet support the proc-fs
> 
> 
> bash-2.05a# cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>    Vendor: HP       Model: 4.26GB A 50-S65A Rev: S65A
>    Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 04 Lun: 00
>    Vendor: Seagate  Model: STT20000N        Rev: 6A51
>    Type:   Sequential-Access                ANSI SCSI revision: 02
> 
> 
> 
> Maybe it is settings, but it is not intuitive.  The old Advansys Cards were 
> great, and now you can't get them.  I chose Initio because they took over 
> Advansys (or Connectcom).
> 
> 
> I cannot use the tape drive properly as the SCSI card keeps resetting it's 
> bus and the tape drive locks up..

I've never had a lick of trouble with my initio SCSI cards.
Well, not since i sent them a patch to make the 4 channel
card work with a 2.0 kernel.

Your problem sounds like a termination error or dying tape drive.
Also make sure you use top quality cables.  Most external
cables are junk.

Of course the "VGA compatible controller: nVidia Corporation
Vanta [NV6] (rev 21)." isn't going to get you much support
even if it isn't the problem.

> 
> For completeness, here is my PCI info;
> 
> bash-2.05a# cat /proc/pci
> PCI devices found:
>    Bus  0, device   0, function  0:
>      Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
>        Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
>    Bus  0, device   1, function  0:
>      PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
>        Master Capable.  No bursts.  Min Gnt=12.
>    Bus  0, device   6, function  0:
>      SCSI storage controller: Initio Corporation 360P (rev 2).
>        IRQ 10.
>        Master Capable.  Latency=64.
>        I/O at 0xec00 [0xecff].
>        Non-prefetchable 32 bit memory at 0xdffff000 [0xdfffffff].
>    Bus  0, device   8, function  0:
>      Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
>        IRQ 5.
>        Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
>        Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffefff].
>        I/O at 0xe800 [0xe83f].
>        Non-prefetchable 32 bit memory at 0xdfe00000 [0xdfefffff].
>    Bus  0, device  17, function  0:
>      ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge (rev 0).
>    Bus  0, device  17, function  1:
>      IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
>        Master Capable.  Latency=32.
>        I/O at 0xfc00 [0xfc0f].
>    Bus  0, device  17, function  5:
>      Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
> Controller (rev 16).
>        IRQ 7.
>        I/O at 0xe400 [0xe4ff].
>    Bus  1, device   0, function  0:
>      VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 21).
>        IRQ 11.
>        Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
>        Non-prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
>        Prefetchable 32 bit memory at 0xda000000 [0xdbffffff].
> 
> 
> 
> So if I can't find an Advansys card, what should I use ?
> What SCSI cards do you all recommend?
> 
> Anyone ??
> 
> 
> TIA
> Darryl 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
