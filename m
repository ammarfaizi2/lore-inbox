Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132431AbQLHRfo>; Fri, 8 Dec 2000 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132457AbQLHRfe>; Fri, 8 Dec 2000 12:35:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132431AbQLHRfU>; Fri, 8 Dec 2000 12:35:20 -0500
Subject: Re: Linux 2.2.18pre25
To: wtarreau@yahoo.fr (willy tarreau)
Date: Fri, 8 Dec 2000 17:06:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), wtarreau@free.fr (Willy Tarreau),
        miquels@cistron.nl (Miquel van Smoorenburg),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001208151632.17335.qmail@web1102.mail.yahoo.com> from "willy tarreau" at Dec 08, 2000 04:16:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144QyX-00049w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as soon as I can reboot it, I promise I will test the
> kernel with and without the patch to be really sure.
> but before that, if people who have problems with
> megaraid/netraid could give it a try, that would be
> cool. Also, it would be nice if people for which the
> normal megaraid driver works would accept to check
> this
> doesn't break anything.

Your patch changes the mask on both IO and memory ports to be MEM mask, which
is obviously incorrect. It wont actually bite you because all the masking
has already been done by pci_resource_start() so you are masking already
zero bits.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
