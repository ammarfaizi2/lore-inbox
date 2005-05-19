Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVESPUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVESPUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVESPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:20:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:59099 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262550AbVESPUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:20:06 -0400
From: Andreas Schwab <schwab@suse.de>
To: linux-os@analogic.com
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Illegal use of reserved word in system.h
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	<20050518195337.GX5112@stusta.de>
	<6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	<20050519112840.GE5112@stusta.de>
	<Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	<1116505655.6027.45.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com>
	<jeacmr5mzk.fsf@sykes.suse.de>
	<1116512140.15866.42.camel@localhost.localdomain>
	<Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com>
X-Yow: I'm definitely not in Omaha!
Date: Thu, 19 May 2005 17:19:57 +0200
In-Reply-To: <Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com> (Richard
	B. Johnson's message of "Thu, 19 May 2005 10:36:17 -0400 (EDT)")
Message-ID: <je64xf450i.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> It's also hard to see what is happening in 'C'. When I execute
> this:
>
> #include <stdio.h>
> #include <stdlib.h>
>
> int main(int cnt, char *argv[], char *env[], char *aux[])
> {
>     printf("Aux 0 = %s\n", aux[0]);
> //    printf("Aux 1 = %s\n", aux[1]);
> }

There is no pointer to the aux table passed to main, you have to skip past
the environment.  Also, the aux table is an array of key/value pairs.

> This shows that ld-linux.so, that got called first, didn't
> preserve the vector.

It does.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
