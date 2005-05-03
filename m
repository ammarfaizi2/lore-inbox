Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVECOTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVECOTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVECOSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:18:45 -0400
Received: from citi.umich.edu ([141.211.133.111]:23464 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261593AbVECOP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:15:56 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: Matthew Wilcox <matthew@wil.cx>
Cc: "William A.(Andy) Adamson" <andros@citi.umich.edu>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Michael Kerrisk <mtk-lkml@gmx.net>, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       michael.kerrisk@gmx.net, andros@citi.umich.edu
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question 
In-reply-to: <20050503135946.GC19678@parcelfarce.linux.theplanet.co.uk> 
References: <20050502210411.06226103.sfr@canb.auug.org.au> 
 <2606.1115114418@www14.gmx.net> <20050503231408.7c045648.sfr@canb.auug.org.au>
  <20050503135542.BFBC61BB0E@citi.umich.edu> <20050503135946.GC19678@parcelfarce.linux.theplanet.co.uk>
Comments: In-reply-to Matthew Wilcox <matthew@wil.cx>
   message dated "Tue, 03 May 2005 14:59:46 +0100."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 May 2005 10:15:52 -0400
From: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Message-Id: <20050503141552.F42371BAD1@citi.umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 03, 2005 at 09:55:42AM -0400, William A.(Andy) Adamson wrote:
> > i believe the current implementation is correct. opening a file for write 
> > means that you can not have a read lease, caller included.
> 
> Why not?  Certainly, others will not be able to take out a read lease,
> so there's very little point to only having a read lease, but I don't
> see why we should deny it.
> 

by definition: a read lease means there are no writers. so, the question is 
not 'why not', the question is why? why hand out a read lease to an open for 
write?

-->Andy

