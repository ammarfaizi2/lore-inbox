Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271707AbRHUOnq>; Tue, 21 Aug 2001 10:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271709AbRHUOna>; Tue, 21 Aug 2001 10:43:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271706AbRHUOmt>; Tue, 21 Aug 2001 10:42:49 -0400
Subject: Re: Qlogic/FC firmware
To: davem@redhat.com (David S. Miller)
Date: Tue, 21 Aug 2001 15:45:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 21, 2001 07:28:39 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCmV-00080q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no BIOS flash on my machines (onboard controllers).  The
> kernel driver must be where the firmware comes from to boot reliably.

Ok so you have a sparc specific firmware loading problem. So IMHO the
right thing to do is to write a sparc specific firmware loader - either
as a module living in arch/sparc64 or assuming you never need to reload
the firmware past boot - use an initrd

For the other 99.9% of the userbase we saved 128Kbytes of ram and improved
reliability by not loading half tested firmeware on them.

Alan
