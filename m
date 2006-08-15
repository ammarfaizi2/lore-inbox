Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWHOSpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWHOSpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWHOSpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:45:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:37738 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965114AbWHOSpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:45:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=L4XXYeK9eSCuVQZO5vGhrAepPDIsrXERvdO4332DK8lHbeYpysei+rs8ynzfUhaG9nFV1NJW/IgD+I6jMiSwEstX68prQiMnq4j7ltGoMOuhu9KC3Vhup32nt8R/vWenQPdhMN0607lSxkskZNxJVf8Pjwwzk7Fu2dDO6ofIc6I=
Date: Tue, 15 Aug 2006 22:44:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove NULL check in register_nls()
Message-ID: <20060815184453.GA7482@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everybody passes valid pointer there.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/nls/nls_base.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -163,8 +163,6 @@ int register_nls(struct nls_table * nls)
 {
 	struct nls_table ** tmp = &tables;
 
-	if (!nls)
-		return -EINVAL;
 	if (nls->next)
 		return -EBUSY;
 

