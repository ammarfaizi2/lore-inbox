Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129390AbRAZPHe>; Fri, 26 Jan 2001 10:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRAZPHY>; Fri, 26 Jan 2001 10:07:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7689 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129390AbRAZPHJ>;
	Fri, 26 Jan 2001 10:07:09 -0500
Message-ID: <3A719291.363A40E4@mandrakesoft.com>
Date: Fri, 26 Jan 2001 10:06:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: miles@megapathdsl.net
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.0-pre10 -- Unresolved symbols in smctr.o and comx.o
In-Reply-To: <3A7130EE.E314F4A5@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.1-pre10/kernel/drivers/net/tokenring/smctr.o
> depmod:         __bad_udelay

When you see this, this means you have a -huge- udelay in there, like
udelay(200000) or udelay(50000) or something.

Big delays like that should be converted to mdelay or schedule_timeout.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
