Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbRA3Wuh>; Tue, 30 Jan 2001 17:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132873AbRA3WuR>; Tue, 30 Jan 2001 17:50:17 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:58500 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132549AbRA3WuM>; Tue, 30 Jan 2001 17:50:12 -0500
Message-ID: <3A7746E7.B806CA5A@uow.edu.au>
Date: Wed, 31 Jan 2001 09:57:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL and 3c59x (3c905c-tx)
In-Reply-To: <Pine.LNX.4.30.0101302302080.12548-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> When shutting down my computer with Linux, I cannot wake it up using
> wake-on-LAN, which I can do if I shut it down from WinME or the LILO
> prompt using the power button.
> 
> I see some "interesting" code in 3c59x.c and acpi_set_WOL, and there is
> the following little comment: "AKPM: This kills the 905".
> 
> So, what's up?  Does it break all 905s?  And will not changing the state
> to D3, as a comment a few lines down says, shut the card down, which seems
> to be a bad thing to do in a function called from vortex_probe1...  I know
> this code is currently bypassed, but still, what is this?
> 

The code was broken, so I disabled it.

I
"fixed" WOL in the 2.2.19-pre candidate driver.  It's
at http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19-pre6-1.gz

I'd really appreciate it if you could test the WOL in
that driver.  Then we can port it into 2.4 and try to
fool Linus into thinking it's a bugfix :)

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
