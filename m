Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271935AbRHVGA1>; Wed, 22 Aug 2001 02:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271937AbRHVGAR>; Wed, 22 Aug 2001 02:00:17 -0400
Received: from ns.roland.net ([65.112.177.35]:13839 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S271935AbRHVGAF>;
	Wed, 22 Aug 2001 02:00:05 -0400
Message-ID: <003e01c12acf$c8faefd0$8a1cfa18@gespl2k1>
From: "Jim Roland" <jroland@roland.net>
To: <mcuss@cdlsystems.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <027001c12a5b$e5d29be0$160e10ac@hades>
Subject: Re: Kernel Startup Delay
Date: Wed, 22 Aug 2001 01:00:45 -0500
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

I'm sure others have contributed to this, but depending on how much delay
you're talking about, you may be able to set a startup delay via your SCSI
BIOS (reference the settings screen showing all SCSI IDs and settings for
each) if you have an Adaptec AHA2940, I know you can do this.  Others you
may need to taste before adding seasoning.

If you don't want to, or are unable to adjust the SCSI Controller's BIOS,
you can insert a startup delay if you're using LILO, and have it wait "x"
seconds which you can adjust in tenths of seconds (50=5 seconds) and have
LILO wait before starting the kernel enough time for your drives to startup.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jim Roland, RHCE (RedHat Certified Engineer)
Owner, Roland Internet Services
     "The four surefire rules for success:  Show up, Pay attention, Ask
questions, Don't quit."
        --Rob Gilbert, PH.D.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

----- Original Message -----
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, August 21, 2001 11:11 AM
Subject: Kernel Startup Delay


> Hello!
>
> I am setting up a server with 4 SCSI hard disks, two of which I will
jumper
> to have a delayed spin up as to not bake the power supply.  These two
drives
> will contain a striping RAID.  I am concerned that the kernel will load
off
> of the other drives and attempt to start this RAID before the disks have
> even spun up - is there a way to have the kernel delay its startup for a
> certain number of seconds while all the drives spin up?
>
> Any hints are greatly appreciated.
>
> Mark
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

