Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUHBXAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUHBXAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHBXAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:00:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1018 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263795AbUHBW77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:59:59 -0400
Date: Tue, 3 Aug 2004 00:59:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-ID: <20040802225951.GR2746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'd like to see the patch below included in 2.6.8 .


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sun, 1 Aug 2004 21:02:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
	"Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
	Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL

On Fri, Jul 30, 2004 at 08:30:40AM +1000, Nathan Scott wrote:
>...
> Adrian wrote:
> > 2.6 is a stable kernel series used in production environments.
> > 
> > Regarding Linus' tree, it's IMHO the best solution to work around it 
> > this way until all issues are sorted out.
> 
> I'm not really convinced - the EXPERIMENTAL marking should
> be plenty of a deterent to folks in production environments.
> There are reports of stack overruns on other filesystems as
> well with 4KSTACKS, so doesn't seem worthwhile to me to do
> this just for XFS.


OK, below is a patch that only adds a dependency of 4KSTACKS on 
EXPERIMENTAL.

Considering that not all issues with 4kb stacks are currently corrected, 
this patch should IMHO go in 2.6.8 .


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-mm1-full/arch/i386/Kconfig.old	2004-08-01 20:59:02.000000000 +0200
+++ linux-2.6.8-rc2-mm1-full/arch/i386/Kconfig	2004-08-01 20:59:46.000000000 +0200
@@ -1474,7 +1474,8 @@
 	  to solve problems without frame pointers.
 
 config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	bool "Use 4Kb for kernel stacks instead of 8Kb (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


