Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUGBIU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUGBIU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUGBIU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:20:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:55756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266509AbUGBIUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:20:04 -0400
Date: Fri, 2 Jul 2004 01:19:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yichen Xie <yxie@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
Message-Id: <20040702011903.6360d43b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
References: <Pine.LNX.4.44.0407011747040.4015-100000@kaki.stanford.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yichen Xie <yxie@cs.stanford.edu> wrote:
>
>     http://glide.stanford.edu/linux-lock/err1.html (69 errors)

nfsd4_open_confirm() looks to be a false positive - judging by the comment:

/*
 * nfs4_unlock_state(); called in encode
 */

the caller of this function is supposed to do nfs4_unlock_state() later on.
