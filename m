Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbRFEVQX>; Tue, 5 Jun 2001 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbRFEVQN>; Tue, 5 Jun 2001 17:16:13 -0400
Received: from i1541.vwr.wanadoo.nl ([194.134.214.12]:64384 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S263359AbRFEVQI>; Tue, 5 Jun 2001 17:16:08 -0400
Date: Tue, 5 Jun 2001 23:15:49 +0200
From: Remi Turk <remi@a2zis.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010605231549.D2662@localhost.localdomain>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010605184438.A1390@localhost.localdomain> <E157NaL-0007MD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E157NaL-0007MD-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 05, 2001 at 09:37:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 09:37:52PM +0100, Alan Cox wrote:
> > 2.4.5-ac[4678] all lock hard (no sysreq) when pushing my
> > power-button (setup from the bios to go to standby) or
> > when running apm --standby. (apm version 3.0final, RH6.2)
> > apm --suspend works the way it should.
> > 
> > 2.4.5/2.4.6-pre1 don't hardlock.
> 
> Are you using the same build options for both
> What machine is this - laptop ?

It's not a laptop.
Tbird 950 + Abit KT7 (KT133)

UP APIC is enabled in -ac[4678] and emu10k1 is the in-kernel
version instead of the one from CVS in -ac8 - which shouldn't
matter because -ac[467] ran with the CVS-version.
2.4.6-pre1 runs emu10k1 from CVS.

I'll compile -ac8 without UP-APIC, but I don't think I'll have
time to mail the results until tommorow.

--- 2.4.5-ac8-config    Tue Jun  5 23:05:55 2001
+++ 2.4.6-pre1-config   Tue Jun  5 23:05:57 2001
@@ -20,10 +20,9 @@
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 CONFIG_NOHIGHMEM=y
 CONFIG_MTRR=y
-CONFIG_X86_UP_APIC=y
 CONFIG_X86_UP_IOAPIC=y
-CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
+CONFIG_X86_LOCAL_APIC=y
 CONFIG_NET=y
 CONFIG_PCI=y
 CONFIG_PCI_GOANY=y
@@ -129,9 +128,7 @@
 CONFIG_VGA_CONSOLE=y
 CONFIG_VIDEO_SELECT=y
 CONFIG_SOUND=m
-CONFIG_SOUND_EMU10K1=m
 CONFIG_USB=m
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_UHCI=m
-CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y

-- 
Linux 2.4.6-pre1 #2 Tue Jun 5 18:08:24 CEST 2001
