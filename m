Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWEVLvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWEVLvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEVLvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:25 -0400
Received: from ns.suse.de ([195.135.220.2]:45453 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWEVLvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:17 -0400
To: Chuck Lever <cel@citi.umich.edu>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no, akpm@osdl.org
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory access rights
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:27:07 +0200
In-Reply-To: <20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
Message-ID: <p731wum7110.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@netapp.com> writes:

> Add Badari's function to check access for all the segments in a passed-in
> iov.  We can use the total byte count later.

It seems bogus to me because there is no big reason the access_ok
can't be done later together with the real access. After all the
real access has to check anyways to handle unmapped pages.

To pass checking is more error prone than single pass.

-Andi

