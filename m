Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJ3X6i>; Mon, 30 Oct 2000 18:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbQJ3X63>; Mon, 30 Oct 2000 18:58:29 -0500
Received: from ns.caldera.de ([212.34.180.1]:11783 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129054AbQJ3X6V>;
	Mon, 30 Oct 2000 18:58:21 -0500
Date: Tue, 31 Oct 2000 00:57:40 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
Message-ID: <20001031005740.A17150@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <20001031004500.A16524@caldera.de> <Pine.LNX.4.10.10010301548150.3595-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10010301548150.3595-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 30, 2000 at 03:51:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 03:51:53PM -0800, Linus Torvalds wrote:
> I hate your patch.
> 
> I'd rather see "Rules.make" just base itself entirely off the new-style
> Makefiles, and have it use "$(obj-y)" instead of O_OBJS etc.
> 
> Then, _old_style Makefiles could be fixed up by doing a
> 
> 	include Compat.make

That can't be done.
Old-style Makefiles are playing dirty tricks with defining
L_TARGET and then using O_TARGET for linking some onjects into
an intermediate object.

But the patch I have proposed is _not_ a resend of that old patch.
Instead this is a separate Makefile.inc that does not include the
old Rules.make - because it needs to do the different handling of
symtab objects - and btw it gets simpler because much of the Rule.make
logic is similar to the list-style makefiles.

So Rule.make would only be for the old-style Makefiles that should be
killed as fast as possible.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
