Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbQKPQgq>; Thu, 16 Nov 2000 11:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQKPQge>; Thu, 16 Nov 2000 11:36:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29751 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130747AbQKPQg0>; Thu, 16 Nov 2000 11:36:26 -0500
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 16 Nov 2000 16:04:23 +0000 (GMT)
Cc: chris@scary.beasts.org (Chris Evans), draht@suse.de (Roman Drahtmueller),
        wichert@cistron.nl (Wichert Akkerman), vendor-sec@lst.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <9458.974157102@ocs3.ocs-net> from "Keith Owens" at Nov 14, 2000 10:11:42 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wRWU-0007yG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> request_module has the same effect as running suid.  dev_load() can
> take the interface name and pass it to modprobe unchanged and modprobe
> does not verify its input, it trusts root/kernel.

Then dev_load is being called the wrong way. In older kernels we explicitly
only did a dev_load with user passed names providing suser() was true.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
