Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQJaAD6>; Mon, 30 Oct 2000 19:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQJaADt>; Mon, 30 Oct 2000 19:03:49 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:52751 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129055AbQJaADh>;
	Mon, 30 Oct 2000 19:03:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 15:47:59 -0800."
             <Pine.LNX.4.10.10010301541000.3595-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 11:03:30 +1100
Message-ID: <12654.972950610@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 15:47:59 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Tue, 31 Oct 2000, Keith Owens wrote:
>We should have some REALLY simple and to-the-point rules. Namely:
>
> - object files get linked in the order specified
>
>No ifs, buts, "except when the user doesn't care", or anything like that.
>No extra new logic with fancy new names for FIRST and LAST objects. No,
>that's the wrong thing.

It is the right thing because it self documents which objects really
need a link order and why.  The existing mechanism has demonstrably
failed to do this, resulting in fragile and error prone makefiles.

>The two things are entirely orthogonal, as far as I can see. Except
>historically we've mixed them up (OX_OBJS + O_OBJS is the link-list,
>O_OBJS is the symtab information). And this mixup is what the problems
>come from.

True, which is one of the reasons that kbuild 2.5 will remove OX_OBJS,
MX_OBJS and MIX_OBJS.  But that change affects all Makefiles, we are
supposed to be in a code freeze.  My patch fixes usb and only affects
usb, not the entire kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
