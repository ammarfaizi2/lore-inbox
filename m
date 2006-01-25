Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWAYAWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWAYAWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWAYAWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:22:39 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:56605 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750878AbWAYAWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:22:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uUzysNWXqY7vP/UjmK5SmOK7CpYpLUE7Edo+72Qf4bt03/JNTFtK4jmVWLKJNsrZpDcSkOUre8t3fwfq4xtNdsNFHClOyUTeq8Z2bj/3xG5vxsRbiB6Hj0UqWHblZHx+brLPuyk6XPVByizIZ03GieX/5rtKFx2aqIZOPuxNTxs=
Date: Wed, 25 Jan 2006 03:40:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] suni: cast arg properly in SONET_SETFRAMING
Message-ID: <20060125004018.GA3234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/atm/suni.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/atm/suni.c
+++ b/drivers/atm/suni.c
@@ -188,7 +188,7 @@ static int suni_ioctl(struct atm_dev *de
 		case SONET_GETDIAG:
 			return get_diag(dev,arg);
 		case SONET_SETFRAMING:
-			if (arg != SONET_FRAME_SONET) return -EINVAL;
+			if ((int)(unsigned long)arg != SONET_FRAME_SONET) return -EINVAL;
 			return 0;
 		case SONET_GETFRAMING:
 			return put_user(SONET_FRAME_SONET,(int __user *)arg) ?

