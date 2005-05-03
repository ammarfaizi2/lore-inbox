Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVECN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVECN7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVECN7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:59:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52625 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261552AbVECN7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:59:35 -0400
Date: Tue, 3 May 2005 14:59:46 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Michael Kerrisk <mtk-lkml@gmx.net>, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, matthew@wil.cx, schwidefsky@de.ibm.com,
       michael.kerrisk@gmx.net
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
Message-ID: <20050503135946.GC19678@parcelfarce.linux.theplanet.co.uk>
References: <20050502210411.06226103.sfr@canb.auug.org.au> <2606.1115114418@www14.gmx.net> <20050503231408.7c045648.sfr@canb.auug.org.au> <20050503135542.BFBC61BB0E@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503135542.BFBC61BB0E@citi.umich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 09:55:42AM -0400, William A.(Andy) Adamson wrote:
> i believe the current implementation is correct. opening a file for write 
> means that you can not have a read lease, caller included.

Why not?  Certainly, others will not be able to take out a read lease,
so there's very little point to only having a read lease, but I don't
see why we should deny it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
