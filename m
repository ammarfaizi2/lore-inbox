Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129275AbQKAJ3m>; Wed, 1 Nov 2000 04:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQKAJ3c>; Wed, 1 Nov 2000 04:29:32 -0500
Received: from scispor.dolphinics.no ([193.71.152.117]:37650 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S129275AbQKAJ3Y>; Wed, 1 Nov 2000 04:29:24 -0500
Message-Id: <200011010850.eA18oxc26996@scispor.dolphinics.no>
From: "Simen Timian Thoresen" <simentt@dolphinics.no>
To: Simon Byrnand <sbyrnand@xtra.co.nz>
Date: Wed, 1 Nov 2000 10:29:42 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: SMP freeze in <= 2.2.17 when toggling consoles
Reply-to: simen-tt@online.no
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20001101213931.01275ad0@pop3.xtra.co.nz>
X-mailer: Pegasus Mail for Win32 (v3.12b)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Recently while trying to pin down SCSI errors with a Dual PII machine with
> onboard SCSI I discovered a nasty and easily repeatable way to cause a
> total system freeze.
> 
> Tyan Thunder 100 M/B
> 256MB ram
> 2x PII-233 (klamath core)
> Onboard dual channel AIC-7895 (aic7xxx driver built into the kernel)
> Onboard eepro100 compatible ethernet.
> 2x Seagate ST34501W, 4GB, 10,000rpm drives

Ok, our system is  
Epox KP6-BS, (Also a dual 440BX)
256MB ram
2x PIII-750MHz Coppermine
Adaptec AHA-294X Ultra SCSI host adapter (Ultra Wide)
2x Kingston K110TX (Lite on tulip) nics
1x 20MB/s raid unit.
 
> The symptom is basically this - under heavy disk activity, rapidly
> switching virtual consoles will trigger a system freeze. Nothing will
> revive the machine, the Magic Sysreq key is also inoperable. Generally I
> can get it to freeze within a couple of seconds. If I just switch consoles
> slowly it doesnt seem to freeze, but holding down ALT and tapping
> F1-F2-F1-F2 as quick as possible will freeze it in a few seconds. Quite
> often it will even freeze right in the middle of redrawing the new console
> - The top half of the screen will show part of the console you were
> switching to, while the bottom is still showing the previous console
> because it froze before it finished drawing the screen.

I've tried this a few times, but was unable to get the system to crash.
I tried varying block-sizes and against both the ata-controller and the raid-box.
 
You might want to try to reproduce your problems with another scsi-
controller, cable and disk comination, and also against an ide disk.

Good luck.

-Simen
--
Simen Thoresen, Beowulf-cleaner and random artist.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
