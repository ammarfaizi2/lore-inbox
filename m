Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129238AbQKFJBL>; Mon, 6 Nov 2000 04:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbQKFJBC>; Mon, 6 Nov 2000 04:01:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65033 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129238AbQKFJAr>;
	Mon, 6 Nov 2000 04:00:47 -0500
Message-ID: <3A067318.E9C6ADDF@mandrakesoft.com>
Date: Mon, 06 Nov 2000 04:00:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: ryan <ryan@netidea.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: <1459.973469046@kao2.melbourne.sgi.com>
		<3A060BE5.8877F477@netidea.com> <14854.8617.282831.205647@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> It looks like an interupt is happening while another interrupt is
> happening, which should be impossible... but it isn't.

If multiple interrupts are hitting a single code path (like IDE irqs 14
-and- 15), you definitely have to think about that.  The reentrancy
guarantee only exists when a single IRQ is assigned to a single
handler...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
