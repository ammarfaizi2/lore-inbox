Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130646AbQKPWPV>; Thu, 16 Nov 2000 17:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbQKPWPL>; Thu, 16 Nov 2000 17:15:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22087 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130646AbQKPWPG>; Thu, 16 Nov 2000 17:15:06 -0500
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 16 Nov 2000 21:45:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <4328.974406276@ocs3.ocs-net> from "Keith Owens" at Nov 17, 2000 07:24:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wWqL-0008PT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Then dev_load is being called the wrong way. In older kernels we explicitly
> >only did a dev_load with user passed names providing suser() was true.
> 
> ping6 -I module_name.  ping6 is setuid, it passes the interface name to
> the kernel while it holds root privileges, suser() == true.  It is
> not reasonable to expect setuid programs to know that Linux does
> something special with some parameters when no other O/S has that
> "feature".

ping6 shouldnt be running with CAP_SYS_MODULE in the first place

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
