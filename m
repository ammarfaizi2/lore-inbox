Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQKIWzM>; Thu, 9 Nov 2000 17:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129970AbQKIWzB>; Thu, 9 Nov 2000 17:55:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26630 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129950AbQKIWyt>; Thu, 9 Nov 2000 17:54:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [bug] usb-uhci locks up on boot half the time
Date: 9 Nov 2000 14:54:34 -0800
Organization: Transmeta Corporation
Message-ID: <8uf9va$hi8$1@penguin.transmeta.com>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com> <3A0B27E3.7D10AB64@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A0B27E3.7D10AB64@linux.com>, David Ford  <david@linux.com> wrote:
>
>The oddity is that kdb shows the machine to lock up on the popf in
>pci_conf_write_word()+0x2c.  I never did get around to digging up this
>routine and looking at the code, but I suspect this is a final return
>from the routine.  I'm rather confused however, I have no idea why a
>flags pop would hang the hardware.

Educated guess: it enables interrupts, after it has done something to
the hardware that causes an infinite stream of them.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
