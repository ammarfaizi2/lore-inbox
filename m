Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSA3AUX>; Tue, 29 Jan 2002 19:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSA3AUJ>; Tue, 29 Jan 2002 19:20:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287478AbSA3AST>; Tue, 29 Jan 2002 19:18:19 -0500
Subject: Re: Linux 2.5.2-dj7
To: jsimmons@transvirtual.com (James Simmons)
Date: Wed, 30 Jan 2002 00:30:36 +0000 (GMT)
Cc: pozsy@sch.bme.hu (Pozsar Balazs), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.10.10201291602510.29648-100000@www.transvirtual.com> from "James Simmons" at Jan 29, 2002 04:05:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vie4-0005gE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    In dmi_scan.c this is a hook to deal with the PS/2 mouse on Dell
> Latitude C600. Can someone with this machine test the new input drivers on
> it. I like to see if we need some kind of fix for this device.

You I suspect will. When the machine resumes it likes to re-enable the mouse
pad irrespective of whether it is being used - so you get an IRQ12. Even
more fun if you ignore that IRQ you dont get keyboard events because the
microcontroller (or SMM code impersonating it - who knows these days) is
waiting for the ps/2 event to be handled first.

The alternative (possibly cleaner) fix on those machines would be to turn
the PS/2 port on always and process/discard output if its not wanted by
the user
