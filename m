Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270525AbTGaSYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTGaSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:24:43 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:29615 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S262710AbTGaSYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:24:41 -0400
Date: Thu, 31 Jul 2003 11:23:32 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Steve Dickson <SteveD@redhat.com>
Cc: "Neil F. Brown" <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4 and 2.6 disagree about NFSEXP_CROSSMNT - upward incompatibility, please fix
Message-ID: <20030731182332.GH18733@perlsupport.com>
References: <3F294DE3.9020304@RedHat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F294DE3.9020304@RedHat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Steve Dickson:
> It seems in nfs-utils-1.05 (actually it happen in 1.0.4)
> the NFSEXP_CROSSMNT define was changed to 0x4000 ....

This looks like an actual kernel incompatibility 2.4 <-> 2.6, as
the 2.4 and 2.6 trees disagree about the value of NFSEXP_CROSSMNT.

> So could please add this patch that simply switchs the bits
> so NFSEXP_CROSSMNT stays the same and the new NFSEXP_NOHIDE define
> gets the higher bit?

And 2.6's include/linux/nfsd/export.h needs the same fix.  This needs
to go in before the 2.6.0 release or nfs-utils is in deep kimchi.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
