Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136405AbRAJVI5>; Wed, 10 Jan 2001 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136529AbRAJVIj>; Wed, 10 Jan 2001 16:08:39 -0500
Received: from [216.151.155.116] ([216.151.155.116]:8711 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S136405AbRAJVIR>; Wed, 10 Jan 2001 16:08:17 -0500
To: crosser@average.org (Eugene Crosser)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 tcp over firewall - no connection
In-Reply-To: <93igfm$ooc$1@pccross.average.org>
From: Doug McNaught <doug@wireboard.com>
Date: 10 Jan 2001 16:07:52 -0500
In-Reply-To: crosser@average.org's message of "10 Jan 2001 23:25:26 +0300"
Message-ID: <m3itnnru8n.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

crosser@average.org (Eugene Crosser) writes:

> I noticed rather strange behavior: stock 2.4.0 with old ISA 3Com
> on UP compiled as UP cannot open TCP connection to hosts behind a
> firewall.  E.g. it is impossible to go to http://www.etrade.com/ -
> connect just never finishes.  2.2.17 on the same hardware works
> right.  2.4.0 on SMP over PPP connection works right too.  MTU
> is 1500 in both cases.  In both cases, kernel is compiled with
> netfilter as modules, but those are not loaded.

Known problem, exhaustively discussed on the list, and not related
to your NIC.  Disable ECN (explicit congestion notification), either
in your kernel compile or in /proc/sys/<something>.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
