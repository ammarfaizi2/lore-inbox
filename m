Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293593AbSBZMXY>; Tue, 26 Feb 2002 07:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293595AbSBZMXO>; Tue, 26 Feb 2002 07:23:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293593AbSBZMXB>; Tue, 26 Feb 2002 07:23:01 -0500
Subject: Re: ISO9660 bug and loopback driver bug
To: barubary@cox.net (Barubary)
Date: Tue, 26 Feb 2002 12:37:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <009201c1bebd$7a5f5910$a7eb0544@CX535256D> from "Barubary" at Feb 26, 2002 04:02:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fgrQ-0000Vo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is it locale-dependent?  All ISO9660 file times are stored as Gregorian
> calendar dates regardless of who made them, and the target (UNIX file time)

Thanks - I wasn't aware it was always defined to be the gregorian calendar
in ISO9660. The orthodox calendar differs in computation (its more accurate)
and the two actually diverge in 2800. (Pan Orthodox congress 1923 if anyone
actually cares)

> isn't locale-dependent either.  Why would it affect the calculation if the
> local system used the Muslim calendar?

Unix file time is clean of those problems 

> Shouldn't there be a gregorian_date_to_unix_time() function in the kernel so
> that every driver that needs such conversion can share that implementation?
> It would keep date processing consistent and make it easy to spot date bugs.

Not a bad idea if there are enough file systems doing it.
