Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRAFFbN>; Sat, 6 Jan 2001 00:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132133AbRAFFax>; Sat, 6 Jan 2001 00:30:53 -0500
Received: from jelerak.scrye.com ([207.174.18.194]:19986 "HELO scrye.com")
	by vger.kernel.org with SMTP id <S129994AbRAFFar>;
	Sat, 6 Jan 2001 00:30:47 -0500
Message-ID: <20010106053037.2778.qmail@scrye.com>
Date: Fri, 5 Jan 2001 22:30:37 -0700 (MST)
From: Kevin Fenzi <kevin@scrye.com>
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: X and 2.4.0 problem (video bios probing?) (SOLUTION!)
In-Reply-To: <E14Ee3z-0008R6-00@the-village.bc.nu>
In-Reply-To: <20010105210016.1778.qmail@scrye.com>
	<E14Ee3z-0008R6-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Duh. 

I figured out the problem. In 2.4.0-test13-pre3 is the introduction of
the shmall sysctl. I had installed a package called powertweak a while
back. It looks like powertweak sets any sysctl it doesn't know to 0. 

So, the problem was that there was no shared memory for X. ;( 

I set that up to a reasonable level and all is well. 

sorry for the wild goose chase. :(

kevin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
