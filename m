Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTDEDlU (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDEDlU (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:41:20 -0500
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:21749 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261756AbTDEDlS (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:41:18 -0500
Message-ID: <3E8E5308.5E359463@eyal.emu.id.au>
Date: Sat, 05 Apr 2003 13:52:40 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre7 - hpt366.c does not build
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> So here goes -pre7. Hopefully the last -pre.
> 
> Please try it.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 
-I../ -nost
dinc -iwithprefix include -DKBUILD_BASENAME=hpt366  -c -o hpt366.o
hpt366.c
In file included from hpt366.c:70:
hpt366.h:517: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a
function)
hpt366.h:517: initializer element is not constant
hpt366.h:517: (near initialization for `hpt366_chipsets[5].device')
hpt366.c: In function `hpt_revision':
hpt366.c:183: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this
function
)
hpt366.c:183: (Each undeclared identifier is reported only once
hpt366.c:183: for each function it appears in.)
hpt366.c:184: warning: unreachable code at beginning of switch statement
hpt366.c: In function `init_setup_hpt366':
hpt366.c:1227: `PCI_DEVICE_ID_TTI_HPT372N' undeclared (first use in this
functio
n)
hpt366.c: At top level:
hpt366.c:1289: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a
function)
hpt366.c:1289: initializer element is not constant
hpt366.c:1289: (near initialization for `hpt366_pci_tbl[5].device')
make[4]: *** [hpt366.o] Error 1
make[4]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/ide/pci'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
