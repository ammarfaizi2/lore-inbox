Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRA2IYX>; Mon, 29 Jan 2001 03:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132014AbRA2IYN>; Mon, 29 Jan 2001 03:24:13 -0500
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:60169 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S130281AbRA2IYC>;
	Mon, 29 Jan 2001 03:24:02 -0500
Message-ID: <3A75278F.B41B492B@bigfoot.com>
Date: Mon, 29 Jan 2001 02:19:27 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: More on the VIA KT133 chipset misbehaving in Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
2.4.0:
1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
locks for a bit
2) Detects a maximum of 64mb of ram, unless worked around by the "mem="
switch
3) The clock drifts slowly (more so under heavy load than light load),
leaking time.

I think #2 is because e820h memory detection is not properly implemented on
the KT133 chipset, or because of some silly BIOS bug that VIA has not
addressed.  I have no idea yet why #1 and #3 happen.  If any gurus out there
have any pointers on where I can look, and what I should prod, I know my way
around with a compiler and editor ;)
--
    www.kuro5hin.org -- technology and culture, from the trenches.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
