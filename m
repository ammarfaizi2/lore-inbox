Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbQJ3CsS>; Sun, 29 Oct 2000 21:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129335AbQJ3CsI>; Sun, 29 Oct 2000 21:48:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:24079 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129300AbQJ3Cr6>;
	Sun, 29 Oct 2000 21:47:58 -0500
From: David Hinds <dhinds@lahmed.Stanford.EDU>
Date: Sun, 29 Oct 2000 18:32:30 -0800
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu, corey@world.std.com
Subject: Re: Compile error in drivers/ide/osb4.c in 240-t10p6
Message-ID: <20001029183230.A29522@lahmed.stanford.edu>
In-Reply-To: <20001029144822.B622@jaquet.dk> <m13psPR-000OXnC@amadeus.home.nl> <20001029231257.J625@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001029231257.J625@jaquet.dk>; from rasmus@jaquet.dk on Sun, Oct 29, 2000 at 11:12:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 11:12:57PM +0100, Rasmus Andersen wrote:
> 
> Thanks for the pointer. However my test build still barfs in the final
> link phase because we (in t10p6) morphed drivers/pcmcia/cs.c::pcmcia_
> request_irq into (the static) cs_request_irq. The rename part
> broke the two other places in cs.c where pcmcia_request_irq was
> referenced and the static part made its usage in drivers/net/pcmcia/
> ray_cs.c a bit awkward.

It should be un-morphed back to the way it was.  It was an error that
slipped into a patch I was preparing, because I was hand-editing the
"diff" output to accommodate some changes between the kernel tree and
the separate PCMCIA package.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
