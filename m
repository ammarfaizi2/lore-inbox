Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRDSOIl>; Thu, 19 Apr 2001 10:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135678AbRDSOIb>; Thu, 19 Apr 2001 10:08:31 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:15114 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135689AbRDSOIX>;
	Thu, 19 Apr 2001 10:08:23 -0400
Date: Thu, 19 Apr 2001 09:16:23 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419091623.D31701@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010418233445.A28628@thyrsus.com> <20010419090220.A2291@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419090220.A2291@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Apr 19, 2001 at 09:02:20AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> On Wed, Apr 18, 2001 at 11:34:45PM -0400, Eric S. Raymond wrote:
> > Especially look for CONFIG_* symbols that only occur in .c or .h files.
> > I think almost every one of those lines represents a bug that needs to be
> > fixed.
> 
> It'd be easier to read if they were alphanumerically sorted.

Good thought.  Done.  This feature will be in the 1.2.1 version.
 
> The ones that show up in arch/arm/def-configs are purely because I've been
> keeping back the updates to these files; each time the config structure
> changes, I get a nice big patch from people with the new def-configs.  I
> didn't want to inflict this too regularly on people.

Funny you should mention that.  The first correction patch I was planning
to generate was one to remove orphans in *all* the defconfigs.  I figured
this would be about the least controversial way to start the cleanup, and
it will deal with 82 of the 699 identified broken symbols.  For this case,
I can generate a correct patch mechanically.

Here is the relevant report, generated with kxref.py -f "d&~(c|h|o|m)":

CONFIG_ADDIN_FOOTBRIDGE: arch/arm/defconfig
CONFIG_AEC6210_TUNING: arch/ia64/defconfig
CONFIG_AMD_FLASH: arch/ppc/configs/SM850_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_ASH: arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_AUTODETECT_RAID: arch/ppc/configs/power3_defconfig
CONFIG_BLK_DEV_AEC6210: arch/ia64/defconfig
CONFIG_BLK_DEV_FLD7500: arch/arm/def-configs/clps7500
CONFIG_CERF_CS8900A: arch/arm/def-configs/cerf
CONFIG_CLPS7500_FLASH: arch/arm/def-configs/clps7500
CONFIG_CMD64X_RAID: arch/arm/defconfig arch/ia64/defconfig
CONFIG_CPU_ARM2: arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_CPU_ARM3: arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_CPU_ARM6: arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_CPU_ARM7: arch/arm/def-configs/rpc arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/clps7500 arch/arm/def-configs/sherman
CONFIG_CPU_ARM920: arch/arm/def-configs/integrator
CONFIG_CPU_IS_SLOW: arch/arm/def-configs/empeg
CONFIG_DEBUG_USER_BACKTRACE: arch/arm/def-configs/empeg
CONFIG_EMPEG_HENRY: arch/arm/def-configs/empeg
CONFIG_EMPEG_IR: arch/arm/def-configs/empeg
CONFIG_EMPEG_USB: arch/arm/def-configs/empeg
CONFIG_FB_CLPS711X: arch/arm/def-configs/footbridge arch/arm/def-configs/rpc
CONFIG_FB_MQ200: arch/arm/def-configs/assabet arch/arm/def-configs/neponset
CONFIG_FIREWALL: arch/arm/def-configs/empeg
CONFIG_FLASH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_FRAME_POINTER: arch/arm/defconfig arch/arm/def-configs/a5k arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/brutus arch/arm/def-configs/empeg arch/arm/def-configs/victor arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/lusl7200 arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/arm/def-configs/neponset arch/arm/def-configs/pangolin arch/arm/def-configs/sherman
CONFIG_GDB_STUB_VBR: arch/sh/defconfig
CONFIG_GEMINI: arch/ppc/configs/ibmchrp_defconfig
CONFIG_GENRTC: arch/parisc/defconfig
CONFIG_HIL: arch/parisc/defconfig
CONFIG_HPT366_FIP: arch/arm/defconfig arch/ia64/defconfig
CONFIG_HPT366_MODE3: arch/arm/defconfig arch/ia64/defconfig
CONFIG_IDEDMA_PCI_EXPERIMENTAL: arch/arm/defconfig arch/ia64/defconfig
CONFIG_INET_RARP: arch/arm/def-configs/empeg
CONFIG_INPUT_MOUSEDEV_DIGITIZER: arch/arm/defconfig
CONFIG_INPUT_MOUSEDEV_MIX: arch/arm/defconfig
CONFIG_IP_ALIAS: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/empeg arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_IP_ROUTER: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig arch/m68k/defconfig arch/arm/defconfig arch/arm/def-configs/empeg arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/clps7500 arch/arm/def-configs/shark
CONFIG_IT8172_TUNING: arch/mips/defconfig-it8172
CONFIG_IT8712: arch/mips/defconfig-it8172
CONFIG_JULIETTE_CCD: arch/cris/defconfig
CONFIG_JULIETTE_MEGCCD: arch/cris/defconfig
CONFIG_JULIETTE_SS1M: arch/cris/defconfig
CONFIG_JULIETTE_VIDEO: arch/cris/defconfig
CONFIG_KDB: arch/ia64/defconfig
CONFIG_LAN_SAA9730: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_LL_DEBUG: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_MD_BOOT: arch/ppc/configs/power3_defconfig
CONFIG_MD_STRIPED: arch/arm/defconfig arch/arm/def-configs/lusl7200
CONFIG_MIPS: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_MIPS_IVR: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_MIPS_UNCACHED: arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172
CONFIG_MTD_ARM: arch/arm/def-configs/integrator
CONFIG_MTD_CFI_GEOMETRY: arch/cris/defconfig
CONFIG_MTD_CSTM_CFI_JEDEC: arch/cris/defconfig
CONFIG_MTD_DC21285: arch/cris/defconfig
CONFIG_MTD_ELAN_104NC: arch/cris/defconfig
CONFIG_MTD_NAND: arch/cris/defconfig
CONFIG_MTD_NAND_SPIA: arch/cris/defconfig
CONFIG_MTD_SA1100: arch/cris/defconfig
CONFIG_MTD_SBC_MEDIAGX: arch/cris/defconfig
CONFIG_MTD_SHARP: arch/cris/defconfig
CONFIG_PCMCIA_DEBUG: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_PCMCIA_SERIAL: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_RADIO_EMPEG: arch/arm/def-configs/empeg
CONFIG_ROTTEN_IRQ: arch/mips/defconfig-ddb5476
CONFIG_RTL8129: arch/alpha/defconfig arch/mips/defconfig-ddb5476 arch/mips/defconfig-it8172 arch/ppc/defconfig arch/ppc/configs/common_defconfig arch/ppc/configs/power3_defconfig arch/ppc/configs/ibmchrp_defconfig arch/arm/defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/lart arch/arm/def-configs/shark arch/arm/def-configs/integrator arch/parisc/defconfig
CONFIG_SA1100_CERF_32MB: arch/arm/def-configs/cerf
CONFIG_SA1100_CERF_CMDLINE: arch/arm/def-configs/cerf
CONFIG_SA1100_FREQUENCY_SCALE: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_SA1100_PCMCIA: arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_SA1100_THINCLIENT: arch/arm/def-configs/brutus arch/arm/def-configs/lart arch/arm/def-configs/cerf
CONFIG_SA1100_VOLTAGE_SCALE: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_SASH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_SASH_PATH: arch/ppc/configs/IVMS8_defconfig arch/ppc/configs/SM850_defconfig arch/ppc/configs/SPD823TS_defconfig arch/ppc/configs/TQM823L_defconfig arch/ppc/configs/TQM850L_defconfig arch/ppc/configs/TQM860L_defconfig
CONFIG_SOUND_SA1100_SSP: arch/arm/def-configs/assabet arch/arm/def-configs/lart
CONFIG_SOUND_UDA1341: arch/arm/def-configs/assabet arch/arm/def-configs/neponset
CONFIG_SOUND_YMPCI: arch/ppc/configs/power3_defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/lart arch/arm/def-configs/shark
CONFIG_TOUCHSCREEN_BITSY: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_TOUCHSCREEN_UCB1200: arch/arm/def-configs/brutus arch/arm/def-configs/assabet arch/arm/def-configs/graphicsclient arch/arm/def-configs/lart arch/arm/def-configs/cerf arch/arm/def-configs/neponset arch/arm/def-configs/pangolin
CONFIG_USB_CPIA: arch/arm/defconfig
CONFIG_VICTOR_BOARD1: arch/arm/def-configs/victor arch/arm/def-configs/sherman
CONFIG_VIDEO_CYBERPRO: arch/arm/def-configs/footbridge
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

We shall not cease from exploration, and the end of all our exploring will be
to arrive where we started and know the place for the first time.
	-- T.S. Eliot
