Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTEGOzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTEGOzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:55:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:52443 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263748AbTEGOzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:55:41 -0400
Date: Wed, 07 May 2003 05:54:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 670] New: snd-ice1712 and snd-ice1724 contain functions with the same names
Message-ID: <6150000.1052312040@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=670

           Summary: snd-ice1712 and snd-ice1724 contain functions with the
                    same names
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bunk@fs.tum.de


Trying to compile both snd-ice1712 and snd-ice1724 statically into the kernel
fails as follows:

<--  snip  -->

...
   ld -m elf_i386  -r -o sound/pci/ice1712/built-in.o
sound/pci/ice1712/snd-ice1712.o sound/pci/ice1712/snd-ice1724.o
sound/pci/ice1712/snd-ice1724.o(.text+0x540): In function
`snd_ice1712_akm4xxx_init':
: multiple definition of `snd_ice1712_akm4xxx_init'
sound/pci/ice1712/snd-ice1712.o(.text+0x7580): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x2c0): In function
`snd_ice1712_akm4xxx_reset':
: multiple definition of `snd_ice1712_akm4xxx_reset'
sound/pci/ice1712/snd-ice1712.o(.text+0x7300): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x8c0): In function
`snd_ice1712_akm4xxx_build_controls':
: multiple definition of `snd_ice1712_akm4xxx_build_controls'
sound/pci/ice1712/snd-ice1712.o(.text+0x7900): first defined here
sound/pci/ice1712/snd-ice1724.o(.text+0x0): In function `snd_ice1712_akm4xxx_write':
: multiple definition of `snd_ice1712_akm4xxx_write'
sound/pci/ice1712/snd-ice1712.o(.text+0x7040): first defined here
make[3]: *** [sound/pci/ice1712/built-in.o] Error 1

<--  snip  -->

