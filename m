Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVH3KvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVH3KvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVH3KvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:51:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:32407 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751356AbVH3KvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:51:07 -0400
Date: Tue, 30 Aug 2005 12:51:04 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Pfeiffer <pfeiffer@pds.de>, isdn4linux@listserv.isdn4linux.de,
       Kai Germaschewski <kai.germaschewski@gmx.de>
Subject: Re: [PATCH] isdn_v110 warning fix
Message-ID: <20050830105104.GA6918@pingi3.kke.suse.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Pfeiffer <pfeiffer@pds.de>, isdn4linux@listserv.isdn4linux.de,
	Kai Germaschewski <kai.germaschewski@gmx.de>
References: <200508300105.44247.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508300105.44247.jesper.juhl@gmail.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 01:05:43AM +0200, Jesper Juhl wrote:
> 

This is OK. Even if the codepath is never executed in a way that ret might
be used uninitialized it does not harm to set ret = 0.


Warning fix :
 drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/i4l/isdn_v110.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-orig/drivers/isdn/i4l/isdn_v110.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/drivers/isdn/i4l/isdn_v110.c	2005-08-30 00:59:34.000000000 +0200
@@ -516,11 +516,11 @@
 }
 
 int
-isdn_v110_stat_callback(int idx, isdn_ctrl * c)
+isdn_v110_stat_callback(int idx, isdn_ctrl *c)
 {
 	isdn_v110_stream *v = NULL;
 	int i;
-	int ret;
+	int ret = 0;
 
 	if (idx < 0)
 		return 0;

