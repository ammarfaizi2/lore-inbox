Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWHHTRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWHHTRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWHHTRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:17:08 -0400
Received: from khc.piap.pl ([195.187.100.11]:63173 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S965038AbWHHTRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:17:07 -0400
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Neil Brown <neilb@suse.de>, Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
References: <or8xlztvn8.fsf@redhat.com>
	<17624.29070.246605.213021@cse.unsw.edu.au>
	<44D8732C.2060207@tls.msk.ru>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 08 Aug 2006 21:17:05 +0200
In-Reply-To: <44D8732C.2060207@tls.msk.ru> (Michael Tokarev's message of "Tue, 08 Aug 2006 15:19:08 +0400")
Message-ID: <m3fyg7m40e.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> Why we're updating it BACKWARD in the first place?

Another scenario: 1 disk (of 2) is removed, another is added, RAID-1
is rebuilt, then the disk added last is removed and replaced by
the disk which was removed first. Would it trigger this problem?

> Also, why, when we adding something to the array, the event counter is
> checked -- should it resync regardless?

I think it's a full start, not a hot add. For hot add contents of
the new disk should be ignored.
-- 
Krzysztof Halasa
