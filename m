Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbSJIP4B>; Wed, 9 Oct 2002 11:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSJIP4B>; Wed, 9 Oct 2002 11:56:01 -0400
Received: from ns.suse.de ([213.95.15.193]:16903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261818AbSJIP4A>;
	Wed, 9 Oct 2002 11:56:00 -0400
To: root@chaos.analogic.com
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
References: <Pine.LNX.3.95.1021009114700.6928B-100000@chaos.analogic.com>
X-Yow: Put FIVE DOZEN red GIRDLES in each CIRCULAR OPENING!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 09 Oct 2002 18:01:42 +0200
In-Reply-To: <Pine.LNX.3.95.1021009114700.6928B-100000@chaos.analogic.com> ("Richard
 B. Johnson"'s message of "Wed, 9 Oct 2002 11:56:00 -0400 (EDT)")
Message-ID: <jed6qj1tzt.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

|> Well, yes I found out.. This anomaly with the assembler.....
|> 
|> .section .data
|> .global	pars
|> .type	pars,@object
|> .size	pars,4
|> .align  4
|> pars:	.long	0
|> .end
|> 
|> 
|> I accidentally left out .size, guess what? Even though I had an
|> offset recognized and a ".long", initialized to 0, there was no
|> space allocated and therefore the seg-fault. I would have seen
|> this, but the problem doesn't exist if the ".section" is ".bss",
|> the first section I was messing with. Go figure?

I think this problem only exists on platforms with COPY relocations.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
