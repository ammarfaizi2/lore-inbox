Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129386AbQKHSRC>; Wed, 8 Nov 2000 13:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129451AbQKHSQw>; Wed, 8 Nov 2000 13:16:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14898 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129386AbQKHSQl>; Wed, 8 Nov 2000 13:16:41 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 8 Nov 2000 18:17:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011080953130.16579-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 08, 2000 10:10:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tZmZ-0000Gp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It won't fail on other CPU's. The bug is, as far as I can tell, in
> get_model_name(),
> 
> 	cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));

Dave Jones fixed this one - for intel we don't use get_model_name() blindly
now. I can see how some earlier 2.2.18pre's would have blown up, but 2.2.17
would (fortunately) be ok.

Thanks

> Notice how we overwrite the x86_capability state with whatever we read
> from the extended register 0x80000001. So we overwrite the _real_
> capabilities that we got the right way in head.S.

Yep

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
