Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWG0NHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWG0NHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWG0NHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:07:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32992 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161039AbWG0NHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:07:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JeYxFZlGx5L8ZevMzYRQggx+PwPQ9e+2iJOm0o9WJeafZPi8b646yXbOYVOdomvKUmg1cMauFUezDvy8z/2fFLdruZan5osAQAuBzvPfEf9Ex07zYimDRww7m8odS1L9pyv6U0vMdNf+c8sZhD1WVsd0O2c5eE+ZbscYx1vB588=
Message-ID: <215036450607270607o4955f3cau19669ab9c90e0e94@mail.gmail.com>
Date: Thu, 27 Jul 2006 21:07:51 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       ipw2100-admin@linux.intel.com
Subject: [PATCH]: Add check return result while call create_workqueue() for ipw2200
Cc: linux-kernel@vger.kernel.org, "Randy Dunlap" <randy.dunlap@oracle.com>,
       wim.coekaerts@oracle.com, wangwengang1976@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add check return result on call create_workqueue().

Signed-off-by: Joe Jin <lkmaillist@gmail.com>
---

--- linux-2.6.17.7/drivers/net/wireless/ipw2200.c       2006-07-27
20:27:01.000000000 +0800
+++ linux.new/drivers/net/wireless/ipw2200.c    2006-07-27
20:28:22.000000000 +0800
@@ -10139,6 +10139,9 @@
        int ret = 0;

        priv->workqueue = create_workqueue(DRV_NAME);
+       if(NULL == priv->workqueue){
+               return -ENOMEM;
+       }
        init_waitqueue_head(&priv->wait_command_queue);
        init_waitqueue_head(&priv->wait_state);


-- 
Regards,
Feng Jin
