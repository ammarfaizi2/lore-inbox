Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282817AbRLGJTp>; Fri, 7 Dec 2001 04:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282818AbRLGJTf>; Fri, 7 Dec 2001 04:19:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282817AbRLGJT2>; Fri, 7 Dec 2001 04:19:28 -0500
Subject: Re: kernel: ldt allocation failed
To: vkire@pixar.com (Kiril Vidimce)
Date: Fri, 7 Dec 2001 09:28:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dmaas@dcine.com (Dan Maas),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.21.0112070108090.20196-100000@tombigbee.pixar.com> from "Kiril Vidimce" at Dec 07, 2001 01:13:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CHIl-0005BF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without turning this into a religous debate, is there any way to
> find out what those messages really mean? When does one run into
> an ldt allocation failure? What is ldt? I am not just trying to
> solve this problem; I also want to understand what is going on
> in the kernel.

Have a look in arch/i386/kernel/*.c. LDT is a descriptor table of segment
registers. Its generally used by emulators to run things like win16 binaries
and sometimes by threaded apps to do thread specific address spaces by
giving each thread a different %fs or %gs segment register
