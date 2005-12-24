Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbVLXC4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbVLXC4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 21:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVLXC4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 21:56:12 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:62087 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030614AbVLXC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 21:56:11 -0500
Date: Sat, 24 Dec 2005 11:56:07 +0900 (JST)
Message-Id: <20051224.115607.730554607.masano@tnes.nec.co.jp>
To: trond.myklebust@fys.uio.no
Cc: matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix posix lock on NFS, #2
From: ASANO Masahiro <masano@tnes.nec.co.jp>
In-Reply-To: <1135350151.8167.160.camel@lade.trondhjem.org>
References: <20051223.233839.846934653.masano@tnes.nec.co.jp>
	<1135350151.8167.160.camel@lade.trondhjem.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.11 (Native Windows TTY Support)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] fix posix lock on NFS, #2
Date: Fri, 23 Dec 2005 16:02:31 +0100

> On Fri, 2005-12-23 at 23:38 +0900, ASANO Masahiro wrote:
> > Here is a patch.  It changes nfsd to keep the range of file_lock for
> > later use.  Any comments and feedback are welcome.

> NACK. You cannot copy locks like this. See locks_copy_lock().

Thank you for pointing it out.  I forgot all that point.  I'm trying
to update my patch, but things are complicated.
Do you think it is safe to copy the file_lock table simply with
locks_copy_lock() at that point, or it may break nlm_blocked list in
nfsd?
	
--
masano
