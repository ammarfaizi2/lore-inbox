Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVKHQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVKHQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVKHQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:53:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63504 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965134AbVKHQxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:53:25 -0500
Date: Tue, 8 Nov 2005 17:53:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/kcopyd.c: #if 0 kcopyd_cancel()
Message-ID: <20051108165324.GY3847@stusta.de>
References: <20051108134419.GR3847@stusta.de> <20051108154828.GX26394@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108154828.GX26394@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 03:48:28PM +0000, Alasdair G Kergon wrote:
> On Tue, Nov 08, 2005 at 02:44:19PM +0100, Adrian Bunk wrote:
> > A function that is
> > - not used
> > - empty
> > - without a prototype in any header file
> > should be removed.
>  
> I'd rather you submitted a patch to complete the function and invoke it
> in the appropriate place:-)  But please don't remove comments indicating 
> missing functionality: commenting it out till it's written would be better.

Updated patch below.

> Alasdair

cu
Adrian


<--  snip  -->


This patch #if 0's the not yet implemented global function 
kcopyd_cancel().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/md/kcopyd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14-mm1-full/drivers/md/kcopyd.c.old	2005-11-08 17:41:31.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/md/kcopyd.c	2005-11-08 17:41:59.000000000 +0100
@@ -562,11 +562,13 @@
  * Cancels a kcopyd job, eg. someone might be deactivating a
  * mirror.
  */
+#if 0
 int kcopyd_cancel(struct kcopyd_job *job, int block)
 {
 	/* FIXME: finish */
 	return -1;
 }
+#endif  /*  0  */
 
 /*-----------------------------------------------------------------
  * Unit setup
@@ -685,4 +687,3 @@
 EXPORT_SYMBOL(kcopyd_client_create);
 EXPORT_SYMBOL(kcopyd_client_destroy);
 EXPORT_SYMBOL(kcopyd_copy);
-EXPORT_SYMBOL(kcopyd_cancel);

