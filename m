Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUDHPOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDHPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:14:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9894
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261904AbUDHPOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:14:21 -0400
Date: Thu, 8 Apr 2004 17:14:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408151415.GB31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain> <1081435237.1885.144.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081435237.1885.144.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 09:40:37AM -0500, James Bottomley wrote:
> Whatever seems most convenient that won't impact the flushing fast path,
> I suppose.  It's one of the hottest paths in the system since all data
> transfers go through it for user visibility.

you'd need to take a semaphore there to be safe, so it's basically
unfixable since you can't sleep or just trylock.
