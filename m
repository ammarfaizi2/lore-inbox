Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUHCVbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUHCVbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHCVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:31:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266878AbUHCVbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:31:19 -0400
Date: Tue, 3 Aug 2004 17:31:08 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted
In-Reply-To: <20040803212231.GJ2241@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0408031729100.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Andrea Arcangeli wrote:

> I agree there aren't security issues, but it's still very wrong to
> charge the old user if the admin gives the locked ram to a new user.
> This erratic behaviour shows how much the rlimit approch is flawed for
> named fs objects that have nothing to do with the transient task that
> created them.

If root wants to screw over a user, there's nothing we
can do.  I am not worried about the scenario you describe
because hugetlbfs seems to be used only by Oracle anyway,
so you won't run into issues like you describe.

It would be different for a general purpose filesystem,
but I'd like to see a usage case for your scenario before
making the code overly complex.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

