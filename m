Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbRFFMHD>; Wed, 6 Jun 2001 08:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbRFFMGx>; Wed, 6 Jun 2001 08:06:53 -0400
Received: from AMontpellier-201-1-3-224.abo.wanadoo.fr ([193.252.1.224]:9469
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S261960AbRFFMGo>; Wed, 6 Jun 2001 08:06:44 -0400
Subject: Re: 2.4.5-ac6: IDE deadlocks/bugs + unexpected IO-APIC
From: Xavier Bestel <xavier.bestel@free.fr>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
In-Reply-To: <991759157.22536.9.camel@nomade>
In-Reply-To: <991759157.22536.9.camel@nomade>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 14:03:24 +0200
Message-Id: <991829006.32526.3.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jun 2001 18:39:16 +0200, Xavier Bestel wrote:
> Hi !
> 
> I have an ABit VP6 (Dual PIII, infamous VIA686, onboard IDE + onboard
> HPT370). This is a new machine, so I didn't test it on several kernels.
> 
> Using 2.4.4-ac11 (SMP), it started to deadlock really often when
> accessing the new disk (Seagate Barracuda, udma5, big reiserfs partition
> + swap) I put on the HPT370, even when mounting it.
> 
> Using 2.4.5-ac6, things are much better, but sometimes it hangs at boot
> around "RAMDISK: Loading 4096 blocks [1 disk] into ram disk ..." - I say
> "around" because sometimes it displays "ACPI: Core Subsystem version
> ...", and sometimes not.
> And sometimes it still hangs randomly. No messages, nothing special in
> the logs except an "unexpected IO-APIC" (that's why I put linux-smp in
> Cc:) and 40 Megs (!!) of:
> Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
> Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906986, limit=4906984
> Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
> Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906988, limit=4906984
> Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
> Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906986, limit=4906984
> Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
> Jun  2 23:11:58 bip kernel: 07:00: r<6>07:00: rw=0, want=4906988, limi4
> Jun  2 23:11:58 bip kernel: att<6>07:4
> Jun  2 23:11:58 bip kernel: attemp<6>07:00: rw=0, want=4906988, 4
> Jun  2 23:11:58 bip kernel: att<6>07:004
> Jun  2 23:11:58 bip kernel: attemp<6>07:00: rw=0, want=4906988, li4
> Jun  2 23:11:58 bip kernel: atte<6>07:004
> Jun  2 23:11:58 bip kernel: att<6>07:00: rw=0, want=4906988, l4
> Jun  2 23:11:58 bip kernel: attempt t<6>074
> Jun  2 23:11:58 bip kernel: attem<6>07:00: rw=0, want=4906988, limit=4
> Jun  2 23:11:58 bip kernel: at<6>07:00: rw=0, 4
> Jun  2 23:11:58 bip kernel: atte<6>07:00: rw=0, want=4906988, limit=4
> 
> dated between Jun  2 23:11:58 and Jun  2 23:14:10
> 
> The thing that annoys me is that today, I just found the my /etc/motd
> with junk appended (a bit of C code). /etc/motd is on my root partition
> on a disk (Seagate ST36531A, big ext2 partition + swap) NOT on the
> HPT370, but on the first onboard IDE.
> 
> 
> I know (now that I looked a bit in the archives) that the VIA686 chipset
> isn't reliable. Any hint to make my PC work while keeping reasonable
> performance ?
> What should I do to help ?
> 
> Xav

Seems to be working better with -ac9, thanks to Jeff's patch I guess. No
more need for "noapic".

Xav

