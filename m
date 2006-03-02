Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWCBT4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWCBT4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWCBT4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:56:40 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:48561 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1752064AbWCBT4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:56:40 -0500
To: jdike@addtoit.com
CC: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20060302180452.GA9188@ccure.user-mode-linux.org> (message from
	Jeff Dike on Thu, 2 Mar 2006 13:04:52 -0500)
Subject: Re: [PATCH] Add O_NONBLOCK support to FUSE
References: <20060301022944.GB9624@ccure.user-mode-linux.org> <E1FENzJ-0008S7-00@dorka.pomaz.szeredi.hu> <20060302180452.GA9188@ccure.user-mode-linux.org>
Message-Id: <E1FEtuJ-0004GR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 02 Mar 2006 20:56:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Found the BUG, patch below.  Feel free to merge it with the async
> patch even though it is signed off on its own.

OK.

And I think the 'fc->fasync = NULL' is redundant, since
fasync_helper() should have already set it to NULL (fc->fasync list
will contain at most one item).

Committed both changes.

Miklos
