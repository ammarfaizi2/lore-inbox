Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYJvC>; Sat, 25 Nov 2000 04:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYJux>; Sat, 25 Nov 2000 04:50:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48388 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129153AbQKYJup>;
        Sat, 25 Nov 2000 04:50:45 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011250917.eAP9HGK18904@flint.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sat, 25 Nov 2000 09:17:16 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011250433.eAP4Xbf113799@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 24, 2000 11:33:37 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> ---- example report of the above crash ----
> kernel NULL (0000002c) accessed from c01a4b98
> GPRs c0294041 00000000 c01a4600 0000000a 00000200 c0258000 ffffffff
> OSRs 00000000 00403100 c0100000 00000002
> RAR c0105344 SP c0294080 FCR 00000000 FSR 00000000
> Stack: 00000000 00000000 00000000 00000000 00000000 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000
>        00000000 00000000 00000000 00000000 00000000 00000000
> Trace: bad stack frame
> Code: 8a739052 c000000a 41310001 87052926
> 
> Symbols:
> c000000a __start
> c0105344 qfs_frob_directory
> c01a4600 qfs_cleaner
> c01a4b98 qfs_hash_file_record
> -------------------------------------------
> 
> Well, that first symbol (__start) was really "jump +10", but the
> extra noise doesn't hurt anyone. You get what you need, no matter
> how mangled the oops is. It can be word-wrapped, missing chunks...
> The tool doesn't need to care.

However, now rather than just reading the dump as you can with ksymoops
or whatever, you have to look at the raw data and try to match it up with
a symbol in the list.

So, with that ARM dump I gave you, we'd potentially end up with about 100
lines of symbols, where about 90 of them are useless.  That would be a
backwards step in the development of Linux IMHO.

PS, you're not going to convince me unless you can come up with something
that produces ksymoops-like output, so there's no point continuing.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
