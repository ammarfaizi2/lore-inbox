Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292951AbSCDWhQ>; Mon, 4 Mar 2002 17:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWhH>; Mon, 4 Mar 2002 17:37:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292951AbSCDWgq>; Mon, 4 Mar 2002 17:36:46 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 22:51:11 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <200203042036.PAA04031@ccure.karaya.com> from "Jeff Dike" at Mar 04, 2002 03:36:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16i1IV-0000ss-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hpa@zytor.com said:
> > So why, then, phrase this as a feature request??? 
> 
> Because it requires a hook in the generic kernel allocator that UML can
> use to make sure that all allocated pages are backed on the host.

At the point you actually allocate pages they are being allocated. No hook
is needed. You seem to misunderstand the way the allocation works - we
allocate address space not memory in things like mmap. We allocate pages
on demand when referenced. The page allocator is only called after a page
is referenced
