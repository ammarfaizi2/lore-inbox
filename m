Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422923AbWHZRf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWHZRf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422938AbWHZRf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:35:58 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:56574 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422923AbWHZRf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:35:58 -0400
Subject: Re: [PATCH 6/6] nfs: Enable swap over NFS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20060826143622.GA5260@ucw.cz>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <20060825153812.24254.9718.sendpatchset@twins>
	 <20060826143622.GA5260@ucw.cz>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 19:30:55 +0200
Message-Id: <1156613455.23000.7.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-26 at 14:36 +0000, Pavel Machek wrote:
> Hi!
> 
> > Now that NFS can handle swap cache pages, add a swapfile method to allow
> > swapping over NFS.
> > 
> > NOTE: this dummy method is obviously not enough to make it safe.
> > A more complete version of the nfs_swapfile() function will be present
> > in the next VM deadlock avoidance patches.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> We probably do not want to enable functionality before it is safe...

:-), probably not no, but some ppl might want to live on the edge.

> Also swsusp interactions will be interesting. (Rafael is working on
> swapfile support these days).

Yes, I've considered this, and this was one of the motivators to keep
the functionality under its own config option, so that it might be
mutually exclusive with swsusp to swapfile.


