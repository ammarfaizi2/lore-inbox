Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263619AbREYICU>; Fri, 25 May 2001 04:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263620AbREYICK>; Fri, 25 May 2001 04:02:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:55823 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263619AbREYIB5>;
	Fri, 25 May 2001 04:01:57 -0400
Date: Fri, 25 May 2001 04:04:50 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Philip Blundell <philb@gnu.org>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Configure.help entries wanted
Message-ID: <20010525040450.A6265@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Philip Blundell <philb@gnu.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010525012200.A5259@thyrsus.com> <esr@thyrsus.com> <E153C9U-0001op-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E153C9U-0001op-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Fri, May 25, 2001 at 08:36:52AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Blundell <philb@gnu.org>:
> >CONFIG_ARCH_FTVPCI
> >CONFIG_ARCH_NEXUSPCI
> 
> These symbols both refer to the same thing (the latter is an obsolete name).
> I guess appropriate text would be something like:
> 
>   Say Y here if you intend to run this kernel on a FutureTV (nee Nexus 
>   Electronics) StrongARM PCI card.

Hm.  They're both in active use in 2.4.5pre4.  My cross-referencer shows

CONFIG_ARCH_NEXUSPCI: arch/arm/config.in arch/arm/boot/Makefile arch/arm/kernel/entry-armv.S arch/arm/kernel/arch.c
snark:~/src/linux$ scripts/kxref.py -f "o&~h&~x" -n defconfig | grep FTVPCI
Reading cross-reference database...done.
CONFIG_ARCH_FTVPCI: arch/arm/Makefile arch/arm/config.in arch/arm/boot/compressed/Makefile arch/arm/kernel/Makefile arch/arm/kernel/bios32.c arch/arm/kernel/debug-armv.S arch/arm/def-configs/clps7500 arch/arm/def-configs/shark

On further investigation I find that neither of these symbols is actually 
set in the ARM config file!  This is kind of a mess.  Is it going to be 
fixed in the next merge?

(They're not the only dead symbols.  CONFIG_TBOX and CONFIG_SHARK don't 
have associated questions either.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Courage is resistance of fear, mastery of fear, not absence of fear.
