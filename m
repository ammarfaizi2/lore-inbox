Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRAIXTH>; Tue, 9 Jan 2001 18:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRAIXS6>; Tue, 9 Jan 2001 18:18:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44559 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132479AbRAIXSp>; Tue, 9 Jan 2001 18:18:45 -0500
Subject: Re: Floppy disk strange behavior
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 9 Jan 2001 23:20:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        mchouque@e-steel.com (Mathieu Chouquet-Stringer),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101091642260.9953-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 09, 2001 04:57:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G83i-0007eo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	* dd(1) portability bug. Obviously there - ftruncate(2) is allowed
> to fail on non-regular ones. Fix is trivial and it (or something equivalent)
> should go into the fileutils.
> 	* What should 2.4 do here? I would prefer -EINVAL - it is true
> (requested action is invalid for the arguments we got), it is consistent
> with other systems and it doesn't hide the failure. Data that used to
> be in the file we were trying to truncate is still there. -EPERM is
> arguably wrong here - it's not like the problem was in the lack of
> permissions.

I'd prefer EINVAL. I agree on the rest

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
