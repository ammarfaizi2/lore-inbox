Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264551AbSIVV1x>; Sun, 22 Sep 2002 17:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264557AbSIVV1x>; Sun, 22 Sep 2002 17:27:53 -0400
Received: from bitmover.com ([192.132.92.2]:58298 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264551AbSIVV1w>;
	Sun, 22 Sep 2002 17:27:52 -0400
Date: Sun, 22 Sep 2002 14:32:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020922143257.A8397@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
	ingo Molnar <mingo@redhat.com>
References: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>; from pwaechtler@mac.com on Sun, Sep 22, 2002 at 08:55:39PM +0200
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> AIX and Irix deploy M:N - I guess for a good reason: it's more
> flexible and combine both approaches with easy runtime tuning if
> the app happens to run on SMP (the uncommon case).

No, AIX and IRIX do it that way because their processes are so bloated
that it would be unthinkable to do a 1:1 model.

Instead of taking the traditional "we've screwed up the normal system 
primitives so we'll event new lightweight ones" try this:

We depend on the system primitives to not be broken or slow.

If that's a true statement, and in Linux it tends to be far more true
than other operating systems, then there is no reason to have M:N.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
