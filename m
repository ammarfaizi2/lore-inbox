Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVHRAPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVHRAPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVHRAPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:15:00 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:29567 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751396AbVHRAOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:14:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=uc+RGaPdGgmAkgtLMbPRBCW1mncW0ihstAfHsbH3HvMy1ZeQcNzy6vLvoC6AwpuL0Obp2wWS19WI6GCC/RP4GKd2aniHXCCkEQI1VAjmA7sbWF23HfrMxtg6+pVA0Y7TZjJ4mZKNe7JAfIRq2jrC+F55yUpRt4K8/KWxLjcLXig=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] rename locking functions
Date: Thu, 18 Aug 2005 02:15:07 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508180215.08100.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the naming of these functions :

 sema_init()
 init_MUTEX()
 init_MUTEX_LOCKED()
 init_rwsem()

They are not named very consistent, the naming is confusing and ugly with 
the mix of case and some are named init_* and some *_init.

I propose to clean that up by renaming the functions so they end up as :

 init_sema()
 init_mutex()
 init_mutex_locked()
 init_rwsem()

Since these are very widely used functions a transition period is needed, so 
the patches I'm posting create wrapper functions with the old names for
people to use until they get their code updated.
The patches also change all in-kernel code calling these functions to use the
new names.

I'm only able to test on i386, so please look carefully at these changes. I'm 
currently running a kernel with the patches applied and everything seems fine.



 --
 Jesper Juhl

