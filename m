Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVACXqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVACXqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVACXpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:45:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:30100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbVACXnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:43:25 -0500
Date: Mon, 3 Jan 2005 15:43:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] A different implementation of LSM?
Message-ID: <20050103154323.B469@build.pdx.osdl.net>
References: <41D9D45F.7030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41D9D45F.7030506@gmail.com>; from dktrkranz@gmail.com on Tue, Jan 04, 2005 at 12:25:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luca Falavigna (dktrkranz@gmail.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> One of the biggest limitations of LSM is we can't implement more than
> one handler for each security hook at the same time.
> Is it advisable to revise the actual implementation, introducing a
> doubly linked list based mechanism (such as Netfilter implementation),
> or this is the best solution in order to limit overhead?

This is an intentional limitation.  Arbitrary security models do not
compose well.  And LSM framework allows modules to store state or label
information in kernel objects.  So, the callout isn't the only spot that
would need chaining.  Take a look at the lsm archive, this is being
worked on presently.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
