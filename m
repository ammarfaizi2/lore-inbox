Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbQLKUqY>; Mon, 11 Dec 2000 15:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLKUqP>; Mon, 11 Dec 2000 15:46:15 -0500
Received: from smtp1.free.fr ([212.27.32.5]:49158 "EHLO smtp1.free.fr")
	by vger.kernel.org with ESMTP id <S130307AbQLKUp4>;
	Mon, 11 Dec 2000 15:45:56 -0500
To: alan@lxorguk.ukuu.org.uk
Subject: 2.2.18 + megaraid : success
Message-ID: <976565724.3a3535dca05ac@imp.free.fr>
Date: Mon, 11 Dec 2000 21:15:24 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.43.185
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I've compiled a plain 2.2.18 kernel for the HP NetServer this afternoon,
and guess what ? (ok, I know that you guessed) : the netraid card now works
correctly.

BTW, I noticed that the firmware and bios versions are improperly displayed
(only garbage). According to the code, that's because the identification
method differs between HP and others, so the HP method is disabled for now.
but this one will be wrong too because the major number is taken from
productInfo->FwVer[1]>>8 (which is an u8), instead of >>4.

I hope that tomorrow I will have a bit of time to try to clarify this and make
it display the right version, and properly identify an HP (fwver[0] seems not
to be used on them).

Cheers,
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
