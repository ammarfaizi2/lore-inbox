Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277221AbRJDUmb>; Thu, 4 Oct 2001 16:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJDUmU>; Thu, 4 Oct 2001 16:42:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38927 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277221AbRJDUmK>; Thu, 4 Oct 2001 16:42:10 -0400
Subject: Re: ioremap() vs. ioremap_nocache()
To: davidm@hpl.hp.com
Date: Thu, 4 Oct 2001 21:47:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110040029.f940Tn103671@wailua.hpl.hp.com> from "David Mosberger" at Oct 03, 2001 05:29:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFPM-00044b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, as far as I know, on x86, ioremap() will give write-through
> cached mappings (in the absence of mtrr games).  If this is true, how

On x86 ioremap will give mappings appropriate to the object you map - which
means by default it wil give uncached mappings. The PCI hardware will do
intelligent things in certain cases such as write merging

Alan
