Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268914AbTBSOQR>; Wed, 19 Feb 2003 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268915AbTBSOQR>; Wed, 19 Feb 2003 09:16:17 -0500
Received: from pushme.nist.gov ([129.6.16.92]:34755 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id <S268914AbTBSOQQ>;
	Wed, 19 Feb 2003 09:16:16 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: M5451 (OSS trident.c) did not come out of reset
References: <20030218151138.GU2492@actcom.co.il>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 19 Feb 2003 09:25:54 -0500
In-Reply-To: <20030218151138.GU2492@actcom.co.il> (Muli Ben-Yehuda's message
 of "Tue, 18 Feb 2003 17:11:38 +0200")
Message-ID: <9cfd6lowdn1.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

> Last time I booted 2.5, I noticed that my sound card no longer
> works. The card is:
>
> 00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]
> M5451 PCI AC-Link Controller Audio Device (rev 01)
>
> And the computer is a thinkpad R30. It turns out that this patch, from
> Alan Cox on 01/11/2002, broke it for me, by failing ali_reset_5451 if
> the card doesn't come out of reset:

A similar change came in a 2.4.21pre-ac that broke sound on my Fujitsu
P-2110.  I patched it to return success even if it never appeared to
come out of reset, and sound worked again.  So that's another example.

Ian

