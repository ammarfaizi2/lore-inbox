Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUATNqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUATNqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:46:43 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:38855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265506AbUATNql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:46:41 -0500
Subject: Re: [PATCH] some more fixes for inode.c
From: David Woodhouse <dwmw2@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0401200803150.15071-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0401200803150.15071-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1074606396.29472.6.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Tue, 20 Jan 2004 13:46:37 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 08:06 -0500, Rik van Riel wrote:
> The first chunk refiles the inode on the inode_unused_pagecache
> list if needed, 

Looks sane.

> but I'm not 100% sure we need that change, since
> maybe only completely unused inodes can end up here. David ?

No, I don't see any reason why that should be the case; you can get
iput() called for an inode which happens to have data in the page cache.
This part of the patch is needed.

-- 
dwmw2

