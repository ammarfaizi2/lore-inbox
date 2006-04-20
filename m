Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWDTXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWDTXPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWDTXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:15:42 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:17438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751259AbWDTXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:15:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=sMXuD5faoiaMgzcid+adoS0/UC/NqdenVMswfUtXEHXCKb6vcT/MRX/uErssgC7cK8faCBuZwe8QPZ2JhnU3we1jn4bcdixYD9e9SBqABSjdMRGvhr1kHySyIfO02uOAGlgWHvTGBNxQtNhwNKSMxN93uwWTp44fKT2a5hBzmMM=
Message-ID: <4448161D.9010109@gmail.com>
Date: Thu, 20 Apr 2006 16:15:41 -0700
From: Hua Zhong <hzhong@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: [PATCH] Rename "swapper" to "idle"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the "swapper" process (pid 0) to a more appropriate name "idle". The name "swapper" is not obviously meaningful and confuses a lot of people (e.g., when seen in oops report).

Patch not tested, but I guess it works. :-)

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 41ecbb8..5e3ca4f 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -108,7 +108,7 @@ #define INIT_TASK(tsk)      \
        .cap_permitted  = CAP_FULL_SET,                                 \
        .keep_capabilities = 0,                                         \
        .user           = INIT_USER,                                    \
-       .comm           = "swapper",                                    \
+       .comm           = "idle",                                       \
        .thread         = INIT_THREAD,                                  \
        .fs             = &init_fs,                                     \
        .files          = &init_files,                                  \
