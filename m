Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132450AbQK3A43>; Wed, 29 Nov 2000 19:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132436AbQK3A4T>; Wed, 29 Nov 2000 19:56:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7441 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S132450AbQK3A4K>;
        Wed, 29 Nov 2000 19:56:10 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011292354.eATNsUU04802@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
To: darryl@netbauds.net (Darryl Miles)
Date: Wed, 29 Nov 2000 23:54:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A252BE9.D9F7D040@netbauds.net> from "Darryl Miles" at Nov 29, 2000 04:16:41 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darryl Miles writes:
> Hmm, what about common symbol generation?  i.e. the linker looses the
> ability to throw out "multiply defined symbol" errors where you fail
> to initialise it to a value.

We need to build with -fno-common to be 100% safe in this case.  I'll
run several compilations with this flag tomorrow.

> >We already argue about the extra couple of bytes that xx change to the
> >kernel/a module would cost.  With these change, we save kilo-bytes in
> >disk space (which is important on some systems).
>  
> PDAs!!! :)  Excellent work Russell.

Note that this only affects the storage; the run-time size is exactly
the same in both cases.  I hope my comment above was clear about that.
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
