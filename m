Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129494AbRBSQDD>; Mon, 19 Feb 2001 11:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRBSQCx>; Mon, 19 Feb 2001 11:02:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23057 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129494AbRBSQCk>; Mon, 19 Feb 2001 11:02:40 -0500
Subject: Re: Linux 2.4.1-ac15
To: prumpf@mandrakesoft.com
Date: Mon, 19 Feb 2001 16:03:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        prumpf@parcelfarce.linux.theplanet.co.uk, rusty@linuxcare.com
In-Reply-To: <Pine.LNX.3.96.1010219054120.16489F-100000@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Feb 19, 2001 05:54:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UsmJ-0003kx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rusty had a patch that locked the module list properly IIRC.

So does -ac now. I just take a spinlock for the modify cases that race
against faults (including vmalloc faults from irq context)

