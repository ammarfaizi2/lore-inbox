Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbWEZXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbWEZXav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWEZXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:30:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:56213 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932776AbWEZXau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:30:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UKPMowPo7h2FW9BFahbO3rS1x18U2HC1pH1JI+y7sTdedRUqp89PXXI5HeSRB+5BDuEAkpzhAK2kmwFd1Z240YdBP6vau4vAp/VYktu3w2fqMmf96ZQ3Twjo6VL1/BLtTo6zFd9RFNdJN4dIjC5GK3ca+i9BWBCLUEC4chzLq10=
Date: Sat, 27 May 2006 03:31:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: really return status from decode_recall_args()
Message-ID: <20060526233112.GA7267@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- a/fs/nfs/callback_xdr.c
+++ 1/fs/nfs/callback_xdr.c
@@ -202,7 +202,7 @@ static unsigned decode_recall_args(struc
 	status = decode_fh(xdr, &args->fh);
 out:
 	dprintk("%s: exit with status = %d\n", __FUNCTION__, status);
-	return 0;
+	return status;
 }
 
 static unsigned encode_string(struct xdr_stream *xdr, unsigned int len, const char *str)

