Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQL2KZq>; Fri, 29 Dec 2000 05:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbQL2KZg>; Fri, 29 Dec 2000 05:25:36 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:39182 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129352AbQL2KZW>; Fri, 29 Dec 2000 05:25:22 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Dec 2000 10:54:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: i386: gcc & asm(): wrong constraint for "mull"
Message-ID: <3A4C6D64.17348.73812@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed (with some inspiration from Andy Kleen) that some asm() 
instructions for the ia32 use the "g" constraint for "mull", where my 
Intel 386 Assembly Language Manual suggests the "MUL" instruction needs 
an r/m operand. So I guess the correct constraint is "rm" in gcc, and 
not "g". That change identical assembly output for gcc-2.95.2, but some 
gcc-2.96.x will try a multiplication with an immediate (constant) 
operand for the "g" constarint, and the as will choke on that.
(Redhat 7.0 ships such a version of gcc).

As I won't be online next week, let me say
regards and a good new year to all!

Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
