Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131067AbQKYMvH>; Sat, 25 Nov 2000 07:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYMu5>; Sat, 25 Nov 2000 07:50:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35849 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131067AbQKYMuq>;
        Sat, 25 Nov 2000 07:50:46 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011251211.eAPCBF019116@flint.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sat, 25 Nov 2000 12:11:15 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011251026.eAPAQKG210983@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 25, 2000 05:26:20 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> Yes. Don't you look at the raw data anyway?

I look at the raw stack data from time to time, but mostly I want
the backtrace, PC and LR converted into something more meaningful,
and I don't want the extra clutter of that particular raw data.

> In theory yes, but in practice no. Your kernel isn't a significant
> portion of your address space, so the chance of random data being
> looked up successfully is very low. Maybe a 1% chance on 32-bit
> hardware, and far less on 64-bit hardware.

Not so.  This is my point; on the ARM, when you get stuff like stack
and registers dumped, a lot of the hex numbers can look very much like
addresses in kernel space; most of them are data object symbols and
the like.  There can be a lot of these, and suddenly you'd end up with
most of the System.map being output because something in the dump
somewhere looks like its a symbol.

> Somebody else posted a reasonable hack for the [<>] problem.
> His proposal involved letting multiple values share the same
> markers, something like this:

Yep, now that is one idea I like!
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
