Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRBLWNo>; Mon, 12 Feb 2001 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131416AbRBLWNf>; Mon, 12 Feb 2001 17:13:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39173 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131228AbRBLWNQ>; Mon, 12 Feb 2001 17:13:16 -0500
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
To: carlos@fisica.ufpr.br (Carlos Carvalho)
Date: Mon, 12 Feb 2001 22:11:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <14984.24279.786295.783864@hoggar.fisica.ufpr.br> from "Carlos Carvalho" at Feb 12, 2001 08:08:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SRCN-0008Gj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm... Looks more difficult than I expected. Can we just change the
> one call to BUG to something sensible on alphas? I'm really eager to
> run this kernel..

The 'something sensible' is what you need to define BUG() to be, so its no
harder to do it right IMHO

I suspect adding 

#define BUG()          __asm__ __volatile__("call_pal 129 # bugchk")

to include/asm-alpha/page.h will do the right thing, since it works on 2.4



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
