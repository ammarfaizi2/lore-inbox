Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbQL2CV0>; Thu, 28 Dec 2000 21:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbQL2CVG>; Thu, 28 Dec 2000 21:21:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5637 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130231AbQL2CVB>; Thu, 28 Dec 2000 21:21:01 -0500
Subject: Re: Repeatable Oops in 2.4t13p4ac2
To: cw@f00f.org (Chris Wedgwood)
Date: Fri, 29 Dec 2000 01:52:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti), chris@freedom2surf.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001229144609.B16930@metastasis.f00f.org> from "Chris Wedgwood" at Dec 29, 2000 02:46:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BoiI-0004ch-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am fairly confident something in ac2 is fishy. I can repeatable get
> ac2 to fail with PCMCIA and also reiserfs under load, I absolutely
> cannot get these failures without ac2.

The PCMCIA thing is unlikely to be related (there are no changes on any PCMCIA
that actually worked on 13pre4). Reiserfs might be the trigger because the
quota code changed, but if it did touch it I'd expect it to have failed
to compile

> This is totally repeatable so if you want further diagnostics please
> let me know....

I'm going to go and do a detailed audit of the mm bits I have differing from
Linus. For one I'd be much happier to differ in drivers with Linus and avoid
differing in mm/vm internals stuff.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
