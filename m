Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbUATNxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUATNxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:53:20 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:50394 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265511AbUATNwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:52:53 -0500
Date: Tue, 20 Jan 2004 08:52:44 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] some more fixes for inode.c
In-Reply-To: <1074606396.29472.6.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0401200852240.15071-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, David Woodhouse wrote:
> On Tue, 2004-01-20 at 08:06 -0500, Rik van Riel wrote:

> > but I'm not 100% sure we need that change, since
> > maybe only completely unused inodes can end up here. David ?
> 
> No, I don't see any reason why that should be the case; you can get
> iput() called for an inode which happens to have data in the page cache.
> This part of the patch is needed.

OK, thanks for confirming my suspicions.

Marcelo, could you please apply the patch ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

