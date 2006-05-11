Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbWEKNNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWEKNNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWEKNNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:13:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:62392 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751681AbWEKNNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DSQUme0N+DhhB+QmhHpgNtDX6DSq8rfi7pSf8zFucC8drYKUMgpBqcRhZX3ojAsF3rItcXqw8bEYwLwTLWsT52+g2rxLU0P2/xZOq60kXJKATx8weYdZ6qvACmgqEzJZmkHpVaCyVTi7K8QoQpdV9onTJEdgujAaDEnXFXFbKxI=
Date: Thu, 11 May 2006 17:11:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Martin <lihnucks@gmail.com>, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] ixj: make ixj_set_tone_off() static
Message-ID: <20060511131147.GA23492@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Martin <lihnucks@gmail.com>

Signed-off-by: Matthew Martin <lihnucks@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- linux-vanilla/drivers/telephony/ixj.c
+++ linux-1/drivers/telephony/ixj.c
@@ -5712,7 +5712,7 @@ static int ixj_daa_write(IXJ *j)
 	return 1;
 }
 
-int ixj_set_tone_off(unsigned short arg, IXJ *j)
+static int ixj_set_tone_off(unsigned short arg, IXJ *j)
 {
 	j->tone_off_time = arg;
 	if (ixj_WriteDSPCommand(0x6E05, j))		/* Set Tone Off Period */

