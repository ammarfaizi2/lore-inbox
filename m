Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293583AbSBZLts>; Tue, 26 Feb 2002 06:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293585AbSBZLti>; Tue, 26 Feb 2002 06:49:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293583AbSBZLt1>; Tue, 26 Feb 2002 06:49:27 -0500
Subject: Re: ISO9660 bug and loopback driver bug
To: barubary@cox.net (Barubary)
Date: Tue, 26 Feb 2002 12:04:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006001c1beb9$ea412690$a7eb0544@CX535256D> from "Barubary" at Feb 26, 2002 03:37:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fgL7-0000R4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which is incorrect.  For those that don't know the right algorithm, all
> years that (are divisible by 4) and ((not divisible by 100), or (divisible
> by 400)) are leap years.  ISO file dates on or after March 1, 2100 will be 1

Thats actually locale dependant, but yes. I'll fix that one.

> Now the loopback bug.  Files whose size is greater than 2^31-1 don't work
> with the loopback driver.  It fails with strange errors, like "device not
> found".  This bug prevents DVD-ROM .iso files from being mounted as either

The loopback driver isnt 64bit file I/O aware afaik. That might be trickier
to fix.
