Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUKCLxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUKCLxj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUKCLxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:53:38 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:39830 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261561AbUKCLxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:53:30 -0500
Date: Wed, 3 Nov 2004 12:53:06 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041103115306.GY3571@dualathlon.random>
References: <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random> <235610000.1099435275@flay> <20041103010952.GA3571@dualathlon.random> <41883300.8060707@yahoo.com.au> <20041103020535.GG3571@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103020535.GG3571@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:05:35AM +0100, Andrea Arcangeli wrote:
> because the list is full, then if it's a __GFP_COLD freeing, I should
> put the cold page into the buddy first. While I'm putting the cold page
> into the list instead. So I'm basically off-by one potentially hot page.

Not the case, I'm already putting the page at the other end before
calling free_pages_bulk, so there's no off-by one error and no
modification required.

maybe I misunderstood what you wanted to say.
