Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTL0Qjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 11:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTL0Qjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 11:39:46 -0500
Received: from ns.suse.de ([195.135.220.2]:21472 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264501AbTL0Qjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 11:39:45 -0500
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <20031226110206.28382.qmail@science.horizon.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: O.K.!  Speak with a PHILADELPHIA ACCENT!!  Send out for CHINESE
 FOOD!!
 Hop a JET!
Date: Sat, 27 Dec 2003 17:39:43 +0100
In-Reply-To: <20031226110206.28382.qmail@science.horizon.com> (linux@horizon.com's
 message of "26 Dec 2003 11:02:06 -0000")
Message-ID: <je3cb6rz8w.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

> Or consider the case when the structure doesn't have an explicit size
> and you have a big case statement for parsing it:
>
> switch (a->type) {
> 	case BAR:
> 		process_bar_chunk(((struct bar *)a)++);
> 		break;
> 	case BAZ:
> 		process_baz_chunk(((struct baz *)a)++);
> 		break;
> 	...
> };
>
> Isn't that code a bit nicer looking?  I put the redundant parens

Except that the parens are not redundant.

> in to remind people that I didn't mean to write "(struct bar *)(a++)"
> (which also has its legitimate uses).

Which is why it's parsed this way by default.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
