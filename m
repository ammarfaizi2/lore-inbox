Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWBMOH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWBMOH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBMOH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:07:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53191 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751780AbWBMOHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:07:55 -0500
Date: Mon, 13 Feb 2006 15:06:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] hrtimer: fix multiple macro argument expansion
Message-ID: <20060213140612.GG12923@elte.hu>
References: <Pine.LNX.4.61.0602130211340.23851@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130211340.23851@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> For two macros the arguments were expanded twice, change them to 
> inline functions to avoid it.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

yep. We checked that there are no current users of that macro which 
could expose this double expansion, but still it's better to have this 
fixed in v2.6.16 too.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
