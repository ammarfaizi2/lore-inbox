Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUFQMct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUFQMct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUFQMcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:32:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12772 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266474AbUFQMb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:31:26 -0400
Date: Thu, 17 Jun 2004 14:32:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Takao Indoh <indou.takao@soft.fujitsu.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Cc: Dave Anderson <anderson@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617123239.GA24647@elte.hu>
References: <20040527210447.GA2029@elte.hu> <C7C4545F11DFBEindou.takao@soft.fujitsu.com> <20040617121356.GA24338@elte.hu> <20040617121847.GA30894@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617121847.GA30894@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> Btw, now that we got you in the loop, any chance to see a forward-port
> of netdump to 2.6?  I think diskdump and netdump could share a lot of
> infrastructure, and given we already have the net polling hooks adding
> netdump shouldn't be that much work anymore.

i think a forward port of netdump might already exist - Jeff, Dave?

i agree that netdump and diskdump should be merged. (Red Hat is involved
in the diskdump project too so this is an ultimate goal even though the
patches are divergent.) Basically diskdumping is another IO transport -
the format, userspace tools and much of the non-IO kernel mechanism is
shared. Diskdumping is more complex on the driver level and it also
needs to be more careful because it writes to media so it verifies
various assumptions by reading on-disk sectors before writing to the
area.

	Ingo
