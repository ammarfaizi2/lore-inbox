Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKTxO>; Mon, 11 Dec 2000 14:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLKTwx>; Mon, 11 Dec 2000 14:52:53 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:46332 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129183AbQLKTwo>; Mon, 11 Dec 2000 14:52:44 -0500
Date: Mon, 11 Dec 2000 13:22:18 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <F394unQVK110xQGocT0000136aa@hotmail.com>
Subject: Re: fatal lockup, BIOS/CMOS reset?
X-Mailer: The Polarbar Mailer; version=1.18; build=55
Message-Id: <20001211195253Z129183-439+2982@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Jonathan Brugge" <jonathan_brugge@hotmail.com> on
Sun, 10 Dec 2000 22:49:05 +0100


> I got a message about a bad CMOS and when I looked in my 
> BIOS-settings I saw they were totally reset... No HD's, date was 1/1/2000, 
> etc.

The BIOS will do this at boot time if it detects that the checksum bytes in the
CMOS are incorrect.  That's probably what happened - somehow, one or more bytes
in your CMOS got altered, and during the reboot the BIOS detected this and reset
all CMOS bytes.

The CMOS can be programmed using I/O ports 70h and 71h.  Just a couple of bad
I/O operations to those ports, and your CMOS is toast.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
