Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289826AbSBEWeZ>; Tue, 5 Feb 2002 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSBEWeP>; Tue, 5 Feb 2002 17:34:15 -0500
Received: from gold.he.net ([216.218.149.2]:7955 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S289826AbSBEWeF>;
	Tue, 5 Feb 2002 17:34:05 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.Souza" <jss@pacbell.net>
To: "Daniel Gryniewicz" <dang@fprintf.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel compile problem after reboot
Date: Tue, 19 Feb 2002 14:36:16 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNAECNCAAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <20020205164529.543e8fb9.dang@fprintf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No I don't have ACPI on.
You're right, it reboots right before the screen gets to
"Uncompressing......."


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Daniel
Gryniewicz
Sent: Tuesday, February 05, 2002 1:45 PM
To: jss@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compile problem after reboot


Do you have ACPI turned on?  On one of my boxes (admittedly a laptop),
enabling ACPI causes the computer to reboot before more than "Uncompressing
..." is printed.  Disabling it causes the laptop to boot and run fine,
although no power management.

Daniel

On Tue, 19 Feb 2002 13:24:33 -0800
"J.S.Souza" <jss@pacbell.net> wrote:

> Yes, I did do a 'cp bzImage /boot/vzlinuz-2.4.17'
> I tried the:
> 	cp bzImage /dev/fd0 && rdev /dev/fd0 /dev/hda5
> to no success.  It does the same thing as before, just slower since it's
> from a floppy (reboots the machine).  This time I did configure the kernel
a
> bit and recompile with still no success.  If you have anymore options or
> suggestions, please feel free to pass them on.
> Here's my machine setup since you asked:
>
> Intel 233
> 192 meg Ram
> 10 gb Maxtor HDD (partitioned as hda1:/boot hda5:/ hda?:/swap)
> Intel chipset (PCIset)
>
>
> Here's my lilo.conf file:
>
> ===============================
> boot = /dev/hda
> message = /boot/boot_message.txt
> prompt
> timeout = 1200
>
> change-rules
> 	reset
> vga = normal
>
> image = /vmlinuz
> 	root = /dev/hda5
> 	label = Linux
> 	read-only
> image = /vmlinuz-2.4.17
> root = /dev/hda5
> label = Linux-2.4.17
> read-only
> ================================
>
> It's got to be my configuration or lilo setup (I think) because I can
> install Slackware,Redhat and others on it just fine with their default
> setup.  Anyways, please pass on any info you think might help.
>
>
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Davidovac Zoran
> Sent: Tuesday, February 05, 2002 8:00 AM
> To: J.S.Souza
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Kernel compile problem after reboot
>
>
>
>
> On Tue, 19 Feb 2002, J.S.Souza wrote:
>
> > Date: Tue, 19 Feb 2002 07:47:54 -0800
> > From: J.S.Souza <jss@pacbell.net>
> > To: linux-kernel@vger.kernel.org
> > Subject: Kernel compile problem after reboot
> >
> > I am using Slack 8 with 2.2.19 and trying to install 2.4.17.  The whole
> > compile process goes as planned until I reboot.  After reconfiguring
> > lilo.conf and running lilo to update changes, I reboot and when I select
> the
> > new kernel all I get is
> >
> > Loading Linux........................
> >
> > Then my computer reboots and this continues to do the same until I
select
> > the old kernel and it reboots fine.
> > Did I do something wrong in lilo?  I merely made a duplicate entry with
a
> > different image= and label= entry:
> >
> > image = /boot/vzlinuz-2.4.17
> > root = /dev/hda5
> > label = Linux_2.4.17
> > read-only
> >
> > I perform the standard:
> > make mrproper
> > make menuconfig
> > make dep && make bzImage && make modules &&
> > make modules_install
> > cp System.map to /boot
> > cp bzImage to /boot
> > edit lilo.conf
> > run lilo
> > reboot
> > swear at the computer.
> >
> do configure the kernel! Do not use defaults!
>
> when you did cp bzImage to /boot
> I hope you did cp bzImage /boot/vzlinuz-2.4.17
>
> then try this cp bzImage /dev/fd0
> rdev /dev/fd0 /dev/hda5
>
> try to boot from floppy
>
> if that is ok , reconfigure kernel try to boot it.
> If it still don't boot perhaps your bios can't reach kernel
> for some reason.
>
> if still don't work post description on
> what hardware / disk ?
>
> regards,
>
>  Zoran
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


---
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

