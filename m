Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbULUTgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbULUTgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULUTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:36:36 -0500
Received: from pat.uio.no ([129.240.130.16]:15836 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261508AbULUTfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:35:08 -0500
Subject: Re: 2.4.29-pre2 Oops at find_inode/reiserfs_find_actor
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Manfred Schwarb <manfred99@gmx.ch>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <20041221164610.GC3596@logos.cnet>
References: <5960.1103581732@www50.gmx.net>
	 <20041221164610.GC3596@logos.cnet>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 14:34:52 -0500
Message-Id: <1103657693.10836.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 21.12.2004 Klokka 14:46 (-0200) skreiv Marcelo Tosatti:

> Trond, the following issue noted by you could not generate such 
> corruption could it?
> 

I doubt it. That bug requires the MS_ACTIVE flag to have been cleared.
IOW, you would have to be in the middle of unmounting the filesystem,
and that doesn't really square with the fact that it is being exported
by knfsd.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

