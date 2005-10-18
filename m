Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVJRSbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVJRSbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVJRSbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:31:01 -0400
Received: from mail.linicks.net ([217.204.244.146]:20741 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750787AbVJRSbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:31:00 -0400
From: Nick Warne <nick@linicks.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
Date: Tue, 18 Oct 2005 19:30:44 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
References: <Pine.LNX.4.44.0510141006280.3868-200000@website2.europe.pwc.ca> <20051018080226.GB13299@logos.cnet>
In-Reply-To: <20051018080226.GB13299@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510181930.44170.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 09:02, Marcelo Tosatti wrote:

> > OK, the adjusted patch attached.  I did look at the ifdefs in that file
> > for a few minutes; but I see now I should have done it like this in the
> > first place.
>
> Looks fine - Willy can you keep it in your tree and add it later on to the
> 2.4.33-pre tree?

Hi Marcelo,

I just noticed something - I maybe buggered up:

+
+if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then

I think I done wrong there - should that be:

[ "$CONFIG_INPUT_KEYBDEV" = "n" ]

menuconfig all works correctly, though?

If so I will rectify the patch again.

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

