Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289917AbSBKR7Q>; Mon, 11 Feb 2002 12:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSBKR7H>; Mon, 11 Feb 2002 12:59:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289917AbSBKR66>; Mon, 11 Feb 2002 12:58:58 -0500
Subject: Re: Linux 2.5.4 Sound Driver Problem
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Mon, 11 Feb 2002 18:12:35 +0000 (GMT)
Cc: weber@nyc.rr.com, linux-kernel@vger.kernel.org
In-Reply-To: <200202111746.g1BHkar11371@devserv.devel.redhat.com> from "Pete Zaitcev" at Feb 11, 2002 12:46:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aKwN-0007Ro-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The sound_alloc_dmap() function in dmabuf.c must be changed from using 
> > __get_free_pages() and virt_to_bus() -> pci_alloc_consistent().
> 
> What the hell are you talking about, I changed it long ago.
> Linus uses ymfpci on his Crusoe Picturebook with no problems.
> What is your kernel version?

In the ymfpci case its not the sound_alloc_dmap (at least not in 2.4 but
2.5 might be out of date except in -dj). Its the use of virt_to_bus still
rather than the handles returned from the pci api
