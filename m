Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWEZSjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWEZSjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEZSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:39:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20118 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751273AbWEZSjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:39:21 -0400
Date: Fri, 26 May 2006 13:39:06 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mike@halcrow.us>
Subject: [PATCH] Remove ECRYPT_DEBUG from fs/Kconfig
Message-ID: <20060526183906.GB11923@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060526142117.GA2764@us.ibm.com> <E1FjdCG-000335-IS@localhost.localdomain> <20060526152401.GF17337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526152401.GF17337@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 05:24:01PM +0200, Adrian Bunk wrote:
> On Fri, May 26, 2006 at 09:21:48AM -0500, Mike Halcrow wrote:
> > Use the kernel BUG_ON() macro rather than the eCryptfs
> > ASSERT(). Note that this temporarily renders the
> > CONFIG_ECRYPT_DEBUG build option unused. We certainly plan on
> > using it in the future; for now, is it okay to leave it in
> > fs/Kconfig, or would you like to remove it?
> 
> Remove it as long as it deos nothing - re-adding it when it's
> actually used will be trivial.

This patch removes ECRYPT_DEBUG from fs/Kconfig; apply after the patch
1 from this 10-part patch set.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/Kconfig |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

15ef83ff75ab0b601a2648175c7f60af16ddb31c
diff --git a/fs/Kconfig b/fs/Kconfig
index 67d5568..b68e46e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -955,14 +955,6 @@ config ECRYPT_FS
 	  To compile this file system support as a module, choose M here: the
 	  module will be called ecryptfs.
 
-config ECRYPT_DEBUG
-	bool "Enable eCryptfs debug mode"
-	depends on ECRYPT_FS
-	help
-	  Turn on debugging code in eCryptfs.
-
-	  If unsure, say N.
-
 config HFS_FS
 	tristate "Apple Macintosh file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
