Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTHZKv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTHZKv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:51:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11466 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262639AbTHZKvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:51:54 -0400
Date: Tue, 26 Aug 2003 12:51:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Michal Semler \(volny.cz\)" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4: CONFIG_KCORE_AOUT doesn't compile
Message-ID: <20030826105145.GC7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308252332.46101.cijoml@volny.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 11:32:46PM +0200, Michal Semler (volny.cz) wrote:
> Hi,
> 
> I tried compile 2.6.0-test4, but I got this error messages:
> gcc-3.3, Debian Woody with bunk debs
> 
> arch/i386/mm/built-in.o(.init.text+0x4bf): In function `mem_init':
> : undefined reference to `kclist_add'
> arch/i386/mm/built-in.o(.init.text+0x4ec): In function `mem_init':
> : undefined reference to `kclist_add'
> make: *** [.tmp_vmlinux1] Error 1
> 
> .config included

@Michal:

# CONFIG_KCORE_ELF is not set
CONFIG_KCORE_AOUT=y


I assume you want to change
  Executable file formats
    Kernel core (/proc/kcore) format
to
  ELF


@all:

Is there any specific reason to keep CONFIG_KCORE_AOUT or is it time to 
remove this option?



> Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

