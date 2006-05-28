Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWE1JO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWE1JO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 05:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWE1JO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 05:14:29 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:55876 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S932091AbWE1JO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 05:14:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAKoGeUSHHoI8BAcOKg
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Date: Sun, 28 May 2006 11:15:44 +0200
User-Agent: KMail/1.9.3
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200605281255.49821.kernel@kolivas.org> <200605281521.20876.kernel@kolivas.org> <20060527223945.05cd5b5b.rdunlap@xenotime.net>
In-Reply-To: <20060527223945.05cd5b5b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281115.44854.bonganilinux@mweb.co.za>
X-Original-Subject: Re: gcc 4.1.1 issues with 2.6.17-rc5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 07:39, Randy.Dunlap wrote:
> On Sun, 28 May 2006 15:21:20 +1000 Con Kolivas wrote:
> >
> > Should also mention:
> > binutils-2.15.92.0.2-6.2.102mdk
> >
> > and a missed one:
> > WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference
> > to .exit.text: from .smp_locks after '' (at offset 0x40)
>
> Yep, Jesper posted that one.
> I also see it in ieee1394.o.
>
> So where does the .smp_locks section come from?
> Is this just a section checker bug/issue?
>

It's not gcc 4.1.1 only, my system:

Gnu C                  4.0.1
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre8
e2fsprogs              1.38
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   068
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi 
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc 
snd_util_mem snd_hwdep snd soundcore tg3 i2c_isa i2c_viapro eth1394 ide_cd 
cdrom ohci1394 ieee1394 loop nls_iso8859_1 nls_cp437 vfat fat tuner bttv 
video_buf firmware_class ir_common compat_ioctl32 v4l2_common btcx_risc 
tveeprom videodev video thermal processor fan button ac ehci_hcd uhci_hcd 
usbcore sd_mod sata_via libata scsi_mod

I get theses

WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: 
from .text.acpi_processor_power_init after 'acpi_processor_power_init' (at 
offset 0x1d)
WARNING: drivers/char/ipmi/ipmi_msghandler.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x10)
WARNING: drivers/char/ipmi/ipmi_si.o - Section mismatch: reference 
to .exit.text : from .smp_locks after '' (at offset 0x8)
WARNING: drivers/ieee1394/ieee1394.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x10)
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference 
to .init.tex t: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x8)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x10)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x18)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x20)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x28)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x30)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x38)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x40)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x48)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x50)
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x58)
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference 
to .init.text: from .smp_locks after '' (at offset 0x0)
WARNING: drivers/usb/storage/usb-storage.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x80)
WARNING: net/802/psnap.o - Section mismatch: reference to .exit.text: 
from .smp_ locks after '' (at offset 0x0)
WARNING: net/bluetooth/rfcomm/rfcomm.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x8)
WARNING: net/bluetooth/rfcomm/rfcomm.o - Section mismatch: reference 
to .exit.text: from .smp_locks after '' (at offset 0x10)
