Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTBFW7H>; Thu, 6 Feb 2003 17:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTBFW7H>; Thu, 6 Feb 2003 17:59:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267692AbTBFW64>;
	Thu, 6 Feb 2003 17:58:56 -0500
Date: Thu, 6 Feb 2003 15:06:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Andrew Morton <akpm@digeo.com>, <niteowl@intrinsity.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 kernel bugs
In-Reply-To: <20030206224900.GA15328@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.33L2.0302061504330.10714-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Dave Jones wrote:

| On Thu, Feb 06, 2003 at 01:16:40PM -0800, Andrew Morton wrote:
|
|  > gcc -W generates ten megabytes of warnings, with a few gems.  We really need
|  > finer-grained control of gcc warnings so that the good ones can be turned on.
|  > gcc warnings are being redone at present and this might yet happen...
|
| A 'spare time' project of mine is to get -W builds at least 'mostly clean'
| The low hanging fruit got fixed up a while back. Most of the remainder
| is signed comparison warnings.  gcc-3.4 has promoted this warning to
| show up in regular builds too, so at some point, either a lot of effort
| is going to have to be undertaken to fix those, or we use -Wno-signed-compare
| during builds.
|
|  > As for the rest well gee.  Perhaps we should stick #error's in there to
|  > flush out some people who can test the fixes.
|
| Just for giggles I did a quick audit of the results of a make
| allyesconfig a few weekends ago. The number of drivers we still have
| that need updating to new APIs (from tqueue conversions to cli/sti etc)
| is quite disturbing. There's a lot of groundwork to be done there
| hopefully before we get to a 2.6test phase, or we're going to be
| obsoleting boatloads of drivers.
|
| I meant to clean up the output and feed it all into bugzilla.
| I'll get around to it sometime..

I did a 'make allyesconfig' build about 10 days ago.  I kept a list of
modules that I had to disable due to syntax errors and another list of
linker errors.  Here's that list, for 2.5.59:


make some things build during allyesconfig testing:
	syntax errors:
		RISCOM8=n
		HOTPLUG_PCI_ACPI=n
		ESPSERIAL=n
		SPECIALIX=n
		SC1200_WDT=n
		IEEE1394_PCILYNX=n
		ISDN_DRV_HISAX=n
		ISDN_BOOL=n
		VIDEO_SAA5249=n
		VIDEO_ZR36120=n
		VIDEO_ZORAN=n
		VIDEO_ZORAN_BUZ=n
		VIDEO_ZORAN_DC10=n
		VIDEO_ZORAN_LML33=n
		VIDEO_STRADIS=n
		TUNER_3036=n
		I2O_LAN=n
		MTD_BLKMTD=n
		FTL=n
		IPHASE5526=n
		WAN=n
		RCPCI=n
		DEFXX=n
		EL3=n
		SCSI_INITIO=n
		SCSI_PCI2000=n
		SCSI_PCI2000I=n
		SCSI_DPT_I2O=n
		AIC7XXX_BUILD_FIRMWARE=n
		AIC79XX_BUILD_FIRMWARE=n
		SCSI_NCR53C7xx=n
		SCSI_EATA=n
		SCSI_EATA_DMA=n
		SCSI_DC390T=n
		SCSI_AM53C974=n
		SCSI_GDTH=n
		SCSI_EATA_PIO=n
		FB_MATROX=n
		FB_SIS=n
		FB_PM2=n
		FB_PM3=n
		FB_CYBER2000=n
		FB_IMSTT=n
		FB_CLGEN=n
		cannot link multiple frame buffer drivers:
		  have conflicts in hgafb and fbmem: linux_logo* (6)
		  so FB_HGA=n
		SND_ALS100=n
		SND_AZT2320=n
		SND_CMI8330=n
		SND_DT019X=n
		SND_ES18XX=n
		SND_OPL3SA2=n
		SOUND_AD1816=n
		SND_AD1816A=n
		SND_CS4236=n
		SND_CS4231=n
		SND_CS4232=n
		SND_INTERWAVE=n
		SND_INTERWAVE_STB=n
		SND_OPTI92X_AD1848=n
		SND_OPTI92X_CS4231=n
		SND_OPTI93X=n
		SND_ES968=n
		SND_SB16=n
		SND_SBAWE=n
		SND_WAVEFRONT=n
		SOUND_SB=n
		SOUND_PAS=n
		SOUND_AEDSP16=n
		TRIX_HAVE_BOOT=n
		PSS_HAVE_BOOT=n
		MAUI_HAVE_BOOT=n
		MSNDCLAS_HAVE_BOOT=n
		MSNDPIN_HAVE_BOOT=n
		SOUND_AWE32_SYNTH=n
		SOUND_MSNDCLAS=n
		SOUND_MSNDPIN=n
	link errors:
		ATM_LANE=n
		ATM_ENI=n
		ATM_TCP=n
		ATM_ZATM=n
		ATM_LANAI=n
		ATM_HORIZON=n
		ATM_FORE200E=n
		ATM_IA=n
		ATM_NICSTAR=n
		ATM_NICSTAR_USE_SUNI=n
		ATM_NICSTAR_USE_IDT77105=n
		ATM_IDT77252=n
		ATM_IDT77252_RCV_ALL=n
		ATM_IDT77252_USE_SUNI=n
		ATM_AMBASSADOR=n
		ATM_FIRESTREAM=n
		MOXA_SMARTIO=n
		MOXA_INTELLIO=n
		STALLION=n
		ISTALLION=n
		COMPUTONE=n
		SX=n
		RIO=n
		FTAPE=n
		ZFTAPE=n
		IPMI_KCS=n
		AIRONET4500=n
		STRIP=n
		SK98LIN=n
		SKMC=n
		ELMC_II=n
		NI65=n
		LP486E=n
		APRICOT=n
		COPS=n
		COPS_DAYNA=n
		COPS_TANGENT=n
		LTPC=n
		ARCNET=n
		PCMCIA_3C574=n
		PCMCIA_FMVJ18X=n
		PCMCIA_NMCLAN=n
		AIRONET4500_CS=n
		PCMCIA_XIRTULIP=n
		SCC=n
		6PACK=n
		MKISS=n
		YAM=n
		TOSHIBA_OLD=n
		TOSHIBA_FIR=n
		SCSI_SIM710=n
		CDU31A=n
		SBPCD=n
		I2C_ELEKTOR=n
		ELPLUS=n
		ROCKETPORT=n
		DIGIEPCA=n
		CYCLADES=n
		SONYPI=n
		SCSI_PSI240I=n
		CDU535=n
		MTD_UCLINUX=n
		SOUND_GUS=n
		SOUND_GUS16=n
		SOUND_GUSMAX=n
		SCSI_GENERIC_NCR5380=n
		SCSI_GENERIC_NCR5380_MMIO=n
		EL1=n
		PCMCIA_XIRC2PS=n
		CM206=n
		EL16=n
		NI5010=n
		DMASCC=n
		SCSI_MCA_53C9X=n
		ELMC=n
		IBMLANA=n
		3C515=n
		AT1700=n
###
make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
make -f scripts/Makefile.build obj=arch/i386/boot/compressed \
                                IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
  arch/i386/boot/tools/build -b arch/i386/boot/bootsect arch/i386/boot/setup arch/i386/boot/vmlinux.bin CURRENT > arch/i386/boot/bzImage
Root device is (3, 4)
Boot sector 512 bytes.
Setup is 4880 bytes.
System is 8384 kB
System is too big. Try using modules.
make[1]: *** [arch/i386/boot/bzImage] Error 1
make: *** [bzImage] Error 2


-- 
~Randy

