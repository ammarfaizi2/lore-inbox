Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUELM6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUELM6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbUELM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:58:19 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:62213 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S263544AbUELM6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:58:18 -0400
Date: Wed, 12 May 2004 14:58:13 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: andrea.fracasso@infoware-srl.com, lkml <linux-kernel@vger.kernel.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: ffs() (was: [Linux-NTFS-Dev] SOLVED - Re: PROBLEM: compiling
 NTFS write support)
In-Reply-To: <1084364605.16624.22.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0405121449120.12270-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 May 2004, Anton Altaparmakov wrote:
> On Wed, 2004-05-12 at 12:56, andrea.fracasso@infoware-srl.com wrote:
> > > On Wed, 2004-05-12 at 11:14, andrea.fracasso@infoware-srl.com wrote:
> > >> Hi, I have found a problem compiling te source of kernel 2.6.6, if I
> > >> enable NTFS write support when i run "make" i get this error:
> > >>
> > >> ....
> > >>   CC      fs/ntfs/inode.o
> > >>   CC      fs/ntfs/logfile.o
> > >> {standard input}: Assembler messages:
> > >> {standard input}:683: Error: suffix or operands invalid for `bsf'
> > >> make[2]: *** [fs/ntfs/logfile.o] Error 1
> > >> make[1]: *** [fs/ntfs] Error 2
> > >> make: *** [fs] Error 2
> > >>
> > >> my kernel version is:
> > >> Linux version 2.6.5-AS1500 (root@ntb-gozzolox) (gcc version 3.3.2
> > >> 20031022
> > >> (Red Hat Linux 3.3.2-1)) #3 Thu Apr 15 10:13:11 CEST 2004
> > 
> > The binutils ver is:
> > binutils-2.14.90.0.6-4
> 
> This happens because gcc (wrongly!) optimizes a variable into a constant
> and then ffs() fails to assemble because the bsfl instruction is only
> allowed with memory operands and not constants.

IMHO this should be worked around (fixed) in the inlined __asm__ ffs. Does
it happen only on Opteron or on other platforms as well?

	Szaka

