Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRHFM2f>; Mon, 6 Aug 2001 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbRHFM2Z>; Mon, 6 Aug 2001 08:28:25 -0400
Received: from 20dyn53.com21.casema.net ([213.17.90.53]:47115 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S268202AbRHFM2O>; Mon, 6 Aug 2001 08:28:14 -0400
Message-Id: <200108061223.OAA28861@cave.bitwizard.nl>
Subject: Re: rio_init, tty_io call confusion.  2.4.8-pre4
In-Reply-To: <E15TjO9-0000rK-00@the-village.bc.nu> from Alan Cox at "Aug 6, 2001
 01:21:41 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 6 Aug 2001 14:23:51 +0200 (MEST)
CC: Keith Owens <kaos@ocs.com.au>, R.E.Wolff@BitWizard.nl,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > drivers/char/tty_io calls rio_init and gets a link error when rio is
> > linked into the kenrel because rio_init is declared as static.  However
> > rio_init is also declared as module_init() so it gets called twice, one
> > from tty_io and once from the kernel initcall code.  One of those calls
> > has to go.  If you keep the tty_io call then rio_init cannot be static.
> 
> The tty_io call appears to be stale

Agreed, thought so too, but haven't had the time to look into
it. Alan, while you're at it, can you remove the call and we'll try to
test "in kernel" and "as a module" ASAP. (which looks as if it's going
to be months, as we're swamped with other stuff.....)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
