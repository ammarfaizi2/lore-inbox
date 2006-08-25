Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWHYWQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWHYWQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422864AbWHYWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:16:18 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:24514 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422863AbWHYWQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:16:18 -0400
Date: Fri, 25 Aug 2006 17:16:15 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir
Message-ID: <20060825221615.GA11613@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22796.1156542677@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 10:51:17PM +0100, David Howells wrote:
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > filldir()'s inode number is now type u64 instead of ino_t.
> 
> Btw, in ecryptfs_interpose(), you have:
> 
> 	inode = iget(sb, lower_inode->i_ino);
> 
> But you have to be *very* *very* careful doing that.  i_ino may be
> ambiguous.  My suggestions to make i_ino bigger were turned down by
> Al Viro; and even it were bigger, it might still not be unique.

Is this the case as long as we stay under the same mountpoint?

Mike
