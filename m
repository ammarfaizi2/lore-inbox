Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129489AbRBLPhb>; Mon, 12 Feb 2001 10:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRBLPhV>; Mon, 12 Feb 2001 10:37:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129489AbRBLPhR>; Mon, 12 Feb 2001 10:37:17 -0500
Subject: Re: "Unable to load intepreter" on login - 2.2.14-5.0
To: pault@5emedia.net (Paul Tweedy)
Date: Mon, 12 Feb 2001 15:37:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B6ADB136.3E08%pault@5emedia.net> from "Paul Tweedy" at Feb 12, 2001 03:26:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SL30-0007J5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nothing. Swap is hardly being used at all, and even rebooting with all the
> usual services turned off made no difference, so I can't believe there's
> something gobbling the memory. In single-user mode, top reports nothing
> untoward - 99.8% CPU available, swap at 0% use, plenty of RAM available.

Could be out of memory, could be out of files, could be permissions

> Has *anyone* got any clue, bar a complete reinstall? I'm picking this up as
> I go along.. 

rpm --verify --all

That will check all the packages seem sane. It won't neccessarily help 
identify the problem but can reassure you as what if anything may be corrupt.

If it shows up changes in login, netstat, su and the like then assume the worst.
If it shows permission changes on the library then you have a good idea what
may have happened.

You might also want to look at ps -aux and top data as that may give you a lot
of clues if the machine is apparently behaving but being odd


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
