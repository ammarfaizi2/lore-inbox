Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264586AbUEaJ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUEaJ1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUEaJ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:27:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:63619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264586AbUEaJ1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:27:53 -0400
Date: Mon, 31 May 2004 02:27:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: Re: Linux 2.6.7-rc2
Message-Id: <20040531022713.1e6985ef.akpm@osdl.org>
In-Reply-To: <m3y8n93qak.fsf@telia.com>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
	<m3y8n93qak.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
>  If I put "#if 0" around the *wdata assignment in nfs_writepage_sync,
>  the stack usage goes down to 36, so it looks like gcc is building a
>  temporary structure on the stack and then copies the whole thing to
>  *wdata.

aww, crap.

>  Does this construct save stack space for any version of gcc? Maybe the
>  code should be changed to do a memset() followed by explicit
>  initialization of the non-zero member variables instead.

yes, we should do that.
