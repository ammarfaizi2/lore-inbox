Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285097AbRLRUxN>; Tue, 18 Dec 2001 15:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285133AbRLRUxE>; Tue, 18 Dec 2001 15:53:04 -0500
Received: from cs182072.pp.htv.fi ([213.243.182.72]:16000 "EHLO
	cs182072.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S285097AbRLRUxA>; Tue, 18 Dec 2001 15:53:00 -0500
Message-ID: <3C1FAC8F.699E1287@welho.com>
Date: Tue, 18 Dec 2001 22:52:31 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Mika.Liljeberg@nokia.com, davem@redhat.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi, rmk@arm.linux.ORG.UK
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
In-Reply-To: <200112182029.XAA11287@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:

> > It's ARM in little endian mode.
> 
> I think it is answer to the question.
> 
> No doubts it still has broken misaligned access.

Oops, I think there was a misunderstanding. The linux machine is Intel.
The other one is a non-Linux ARM.

> > Now that you mention it, tcp_parse_options() in input.c seems to expect
> > that the timestamps are word aligned,
> 
> Nope. It does not expect any alignment, but it is really supposed
> to penalise misbehaving cases.

Ahh, I see. There's a kernel exception handler that is supposed to fix
misaligned access? Hacky.

Cheers,

	MikaL
