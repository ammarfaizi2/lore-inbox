Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129681AbRBNNKy>; Wed, 14 Feb 2001 08:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131542AbRBNNKo>; Wed, 14 Feb 2001 08:10:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13839 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131502AbRBNNKf>; Wed, 14 Feb 2001 08:10:35 -0500
Subject: Re: [PATCH] starfire reads irq before pci_enable_device
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Wed, 14 Feb 2001 13:05:59 +0000 (GMT)
Cc: jgarzik@mandrakesoft.mandrakesoft.com (Jeff Garzik),
        alan@redhat.com (Alan Cox), becker@scyld.com (Donald Becker),
        jes@linuxcare.com (Jes Sorensen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102140452140.14404-100000@age.cs.columbia.edu> from "Ion Badulescu" at Feb 14, 2001 04:54:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T1dB-0004s2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The way I understand it, IA64 and Alpha cope with it, but at the expense 
> of taking an exception for each packet -- so it's not worth it.

You want to copy_checksum the frame on these platforms, or better yet use
a decent network card that can start the frame on odd word alignment. You need
either the CPU or card to be able to handle misaligns efficiently.

