Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUHCVkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUHCVkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUHCVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:40:31 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:39617 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266890AbUHCVkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:40:09 -0400
Date: Tue, 3 Aug 2004 23:39:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803213942.GL2241@dualathlon.random>
References: <20040803212231.GJ2241@dualathlon.random> <Pine.LNX.4.44.0408031729100.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408031729100.5948-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 05:31:08PM -0400, Rik van Riel wrote:
> If root wants to screw over a user, there's nothing we
> can do.  I am not worried about the scenario you describe
> because hugetlbfs seems to be used only by Oracle anyway,
> so you won't run into issues like you describe.

hugetlbfs isn't only used by oracle. Anyways if you were right then why
is there a IPC_CAP_LOCK in hugetlbfs in the first place? If Oracle is
the only user then just drop such check and stop binding rlimits to
persistent fs objects.

> It would be different for a general purpose filesystem,
> but I'd like to see a usage case for your scenario before
> making the code overly complex.

if calling chown on hugetlbfs makes no sense then why is chown available
in the first place?
