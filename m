Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRAIVgR>; Tue, 9 Jan 2001 16:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131810AbRAIVgK>; Tue, 9 Jan 2001 16:36:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65294 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130231AbRAIVf6>; Tue, 9 Jan 2001 16:35:58 -0500
Subject: Re: Floppy disk strange behavior
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 9 Jan 2001 21:37:07 +0000 (GMT)
Cc: mchouque@e-steel.com (Mathieu Chouquet-Stringer),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101091540330.9953-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 09, 2001 04:22:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G6S5-0007UK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dd bug. It tries to ftruncate() the output file and gets all upset when
> kernel refuses to truncate a block device (surprise, surprise).

Standards compliant but unexpected. 

> Basically, dd(1) expects kernel to fake success for ftruncate() on the
> things that can't be truncated. Bad idea. 2.2 didn't bother to report

Actually its explicitly mentioned by the spec that truncate _may_ extend
a file but need not do so. 

> Try to build GNU dd on other Unices and you will be able to trigger that
> bug on quite a few of them.

I think not

> ftruncate(2) is _not_ supposed to succeed on anything other than regular
> files. I.e. dd(1) should not call it and expect success if file is not
> regular. Plain and simple...

2.2 is least suprise 2.4 is most information, but misleading errno IMHO

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
