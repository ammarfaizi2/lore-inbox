Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbTJKOod (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTJKOod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 10:44:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43242 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263313AbTJKOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 10:44:08 -0400
Date: Sat, 11 Oct 2003 16:44:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Atul Mukker <Atul.Mukker@lsil.com>, linux-megaraid-devel@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre7: build error with both megaraid drivers enabled
Message-ID: <20031011144400.GB25478@fs.tum.de>
References: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following build error when trying to compile both megaraid 
drivers statically into the kernel:

<--  snip  -->

...
rm -f scsidrv.o
ld -m elf_i386  -r -o scsidrv.o scsi_mod.o sim710.o advansys.o pci2000.o 
pci2220i.o psi240i.o BusLogic.o dpt_i2o.o u14-34f.o ultrastor.o 
aha152x.o aha1542.o aha1740.o aacraid/aacraid.o aic7xxx/aic7xxx.o 
aic7xxx/aic79xx.o ips.o fd_mcs.o fdomain.o in2000.o g_NCR5380.o 
NCR53c406a.o NCR_D700.o 53c700.o sym53c416.o qlogicfas.o qlogicisp.o 
qlogicfc.o qla1280.o pas16.o seagate.o t128.o dmx3191d.o dtc.o 
53c7,8xx.o sym53c8xx_2/sym53c8xx_2.o eata_dma.o eata_pio.o wd7000.o 
NCR53C9x.o mca_53c9x.o ibmmca.o eata.o tmscsim.o AM53C974.o megaraid.o 
megaraid2.o atp870u.o gdth.o initio.o a100u2w.o ide-scsi.o 3w-xxxx.o 
ppa.o imm.o scsi_debug.o cpqfc.o nsp32.o st.o osst.o sd_mod.o sr_mod.o 
sg.o
megaraid2.o(.text+0x2ce0): In function `megaraid_info':
: multiple definition of `megaraid_info'
megaraid.o(.text+0x2e80): first defined here
ld: Warning: size of symbol `megaraid_info' changed from 68 in 
megaraid.o to 61 in megaraid2.o

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

