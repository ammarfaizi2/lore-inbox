Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWDUWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWDUWtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDUWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:49:19 -0400
Received: from gherkin.frus.com ([192.158.254.49]:31760 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1750713AbWDUWtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:49:18 -0400
Subject: Re: strncpy (maybe others) broken on Alpha
In-Reply-To: <20060422011205.A1270@jurassic.park.msu.ru> "from Ivan Kokshaysky
 at Apr 22, 2006 01:12:05 am"
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, 21 Apr 2006 17:49:17 -0500 (CDT)
CC: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060421224917.34BE5DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> Well, these things happen. I think it's not quite surprising.
> First, the kernel is not overloaded with strncpy calls. ;-)

As I mentioned in an earlier private message, I hope I can be forgiven
for assuming otherwise, particularly since someone went to the trouble
of writing an architecture-specific optimized version of that function.

> Second, strncpy was mostly used in drivers that are rarely (if at all)
> used on alpha.

Which was evidently the case, since this problem didn't surface until
the strncpy() call was added to sd.c.

> Third, to discover this bug you need some special combination of source
> and destination alignment, source string length and byte count.

I'm happy to report my Alpha is now up and running on 2.6.17-rc2, so
the fix works for me.  Thanks to discussion participants for their time
and trouble!

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
