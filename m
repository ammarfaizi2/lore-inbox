Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265421AbRF0WLv>; Wed, 27 Jun 2001 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265429AbRF0WLp>; Wed, 27 Jun 2001 18:11:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62983 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265421AbRF0WLc>; Wed, 27 Jun 2001 18:11:32 -0400
Subject: Re: PROBLEM:Illegal instruction when mount nfs file systems using cyr ixIII
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Wed, 27 Jun 2001 23:10:47 +0100 (BST)
Cc: FrankZhu@viatech.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <200106272019.WAA29237@harpo.it.uu.se> from "Mikael Pettersson" at Jun 27, 2001 10:19:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FNWJ-0005xB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that VIA Cyrix III announces itself (via CPUID)
> as a "family 6" processor, i.e. i686 compatible. This is not
> completely accurate, since it doesn't implement the conditional
> move instruction. [Yeah, I know there's a CPUID feature flag for

Intel specifically state that you cannot use CMOV without checking
for it. Its actually a gcc/binutils tool bug. The CPU is right.

> To make the machine work you'll have to ensure that the kernel,
> user-space libraries and programs, and NFS-imported programs
> all are compiled for a lesser CPU than i686.

For RH 

	rpm -qa |grep ".i686*"

and update the packages listed with their i586/i386 ones. 

Alan

