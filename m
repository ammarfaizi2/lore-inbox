Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbRFUWsa>; Thu, 21 Jun 2001 18:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRFUWsU>; Thu, 21 Jun 2001 18:48:20 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:20228 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265276AbRFUWsJ>;
	Thu, 21 Jun 2001 18:48:09 -0400
Date: Thu, 21 Jun 2001 18:51:44 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010621185144.A8669@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Russell King <rmk@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010621154934.A6582@thyrsus.com> <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home> <20010621234002.Z18978@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621234002.Z18978@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jun 21, 2001 at 11:40:02PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> Eric - would it be easier if I just define_bool CONFIG_XSCALE_IQ80310 n ?

I've done that in my rulesfile, thanks.  Here is the current list of ignored
symbols:

derive CMDLINE_BOOL from n
derive CPU_ADVANCED from EXPERT
derive DRM_AGP from DRM and AGP!=n
derive FB_PCI from FB and PCI
derive FB_TBOX from n
derive NET_ISA from NET_ETHERNET and ISA
derive NET_PCI from NET_ETHERNET and (EISA or PCI)
derive PARTITION_ADVANCED from EXPERT
# These are scheduled to be removed, according to the ARM port manager.
derive CPU_ARM920_CPU_IDLE from n
derive CPU_ARM920_D_CACHE_ON from n
derive CPU_ARM920_I_CACHE_ON from n
# Nicolas Pitre says "This one is currently unmaintained and likely to be 
# removed altogether."
derive SA1100_SHERMAN from n
# These are used in config.in files but nowhere in C code or Makefiles.
# Check this with `scripts/kxref.py -l -f "o&~m&~c&~h&~x" -n defconfig'
derive ARCH_SHARK from n
derive ARCH_TBOX from n
derive BAGETBSM from n
derive CPU_ARM1020 from n
derive CPU_ARM920_WRITETHROUGH from n
derive ETRAX_LED10Y from n
derive ETRAX_LED11Y from n
derive ETRAX_LED12R from n
derive ETRAX_LED8Y from n
derive ETRAX_LED9Y from n
derive GEN_RTC from n
derive GSC from n
derive GSC_DINO from n
derive GSC_PS2 from n
derive LASI_82596 from n
derive MIPS_GT96100 from n
derive PCI_PERMEDIA from n
derive PROFILE from n
derive PROFILE_SHIFT from n
derive SCSI_DECSII from n
derive SCSI_LASI from n
derive SCSI_SIM from n
derive SERIAL_21285_OLD from n
derive SIMETH from n
derive SIM_SERIAL from n
derive USERIAL from n
derive XSCALE_IQ80310 from n

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
