Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTBXVZs>; Mon, 24 Feb 2003 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTBXVZs>; Mon, 24 Feb 2003 16:25:48 -0500
Received: from ns.suse.de ([213.95.15.193]:55825 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267494AbTBXVZr>;
	Mon, 24 Feb 2003 16:25:47 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
X-Yow: Do I have a lifestyle yet?
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 24 Feb 2003 22:35:24 +0100
In-Reply-To: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com> (Linus
 Torvalds's message of "Mon, 24 Feb 2003 13:02:39 -0800 (PST)")
Message-ID: <jeznol5plv.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

|> Does gcc still warn about things like
|> 
|> 	#define COUNT (sizeof(array)/sizeof(element))
|> 
|> 	int i;
|> 	for (i = 0; i < COUNT; i++)
|> 		...
|> 
|> where COUNT is obviously unsigned (because sizeof is size_t and thus 
|> unsigned)?
|> 
|> Gcc used to complain about things like that, which is a FUCKING DISASTER. 

How can you distinguish that from other occurrences of (int)<(size_t)?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
