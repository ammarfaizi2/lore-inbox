Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290618AbSBFPar>; Wed, 6 Feb 2002 10:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290619AbSBFPah>; Wed, 6 Feb 2002 10:30:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290618AbSBFPaW>; Wed, 6 Feb 2002 10:30:22 -0500
Subject: Re: kernel: ldt allocation failed
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 6 Feb 2002 15:37:21 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), linux-kernel@vger.kernel.org
In-Reply-To: <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Feb 06, 2002 04:02:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YU8P-0005VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > allocation a bit (= not allocate 64K of vmalloc space every time
> > sys_modify_ldt is called - there is only 8MB of it)
> 
> What do they use on arches without LDT or equivalent?

Generally on such platforms you have enough registers to use a register
for your thread specific storage. In fact even the kernel does that - you'll
find 'current' on some platforms is a global register variable
