Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSGJUx1>; Wed, 10 Jul 2002 16:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317621AbSGJUx1>; Wed, 10 Jul 2002 16:53:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5137 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317619AbSGJUx0>; Wed, 10 Jul 2002 16:53:26 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
To: kessler@us.ibm.com (Larry Kessler)
Date: Wed, 10 Jul 2002 22:15:45 +0100 (BST)
Cc: garloff@suse.de (Kurt Garloff), alan@lxorguk.ukuu.org.uk (Alan Cox),
       joe.perches@spirentcom.com (Perches Joe), thunder@ngforever.de,
       bunk@fs.tum.de, boissiere@adiglobal.com, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com ('Martin.Bligh@us.ibm.com'),
       rusty@rustcorp.com.au (Rusty Russell)
In-Reply-To: <3D2C88B2.FF9ECD5C@us.ibm.com> from "Larry Kessler" at Jul 10, 2002 12:19:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SOoL-0007q9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kurt Garloff wrote:
> > If you want translated kernel messages, use message IDs, that can be parsed
> > and translated in userspace, 
> 
> Agreed.

> What's been discussed with Rusty Russell (and I believe he has 
> discussed this with Alan) is not modifying the printks, but providing
> logging macros that keep the format string separate from the vararg list
> (but written to a log file as a single event record).

You need a bit more than that. You need a consistent way to report
an IRQ number, a device name, a PCI object etc. That does mean tidying up
printk but not in a bad way. One can imagine either

	"%s", irq_name(irq)

or
	"%I", irq

type solutions
