Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWBNLSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWBNLSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWBNLSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:18:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64949 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030233AbWBNLSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:18:33 -0500
Date: Tue, 14 Feb 2006 12:16:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [PATCH 10/12] hrtimer: remove useless const
Message-ID: <20060214111648.GA26311@elte.hu>
References: <Pine.LNX.4.61.0602141111380.3741@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602141111380.3741@scrub.home>
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

> A const for arguments which are passed by value is completely ignored 
> by gcc. It has only an effect on local variables and even here a 
> recent gcc doesn't need it either to produce better code. I left a few 
> const which help gcc-3.x to produce slightly smaller code.

still nack... Using const is _not a bug_, and in fact there are some 
good reasons to make use of it - so it should be left up to the authors 
of the code how much they make use of const. This patch also creates 
quite some churn in the -hrt queue, for no good reason.

	Ingo
