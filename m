Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292987AbSBVU2o>; Fri, 22 Feb 2002 15:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292986AbSBVU2e>; Fri, 22 Feb 2002 15:28:34 -0500
Received: from f24.law11.hotmail.com ([64.4.17.24]:58129 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S292987AbSBVU2U>;
	Fri, 22 Feb 2002 15:28:20 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: balbir_soni@hotmail.com
Subject: [PATCH] Trivial patch against mempool
Date: Fri, 22 Feb 2002 12:28:14 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F24fGB9wIWXLU9778dv00003562@hotmail.com>
X-OriginalArrivalTime: 22 Feb 2002 20:28:15.0108 (UTC) FILETIME=[74949440:01C1BBDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the alloc_fn and free_fn are not NULL. The caller generally
ensures that alloc_fn and free_fn are valid. It would not harm
to check. This makes the checking in mempool_create() more complete.


--- mempool.c.org       Fri Feb 22 12:00:58 2002
+++ mempool.c   Fri Feb 22 12:01:13 2002
@@ -35,7 +35,7 @@
        int i;

        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
-       if (!pool)
+       if (!pool || !alloc_fn || !free_fn)
                return NULL;
        memset(pool, 0, sizeof(*pool));


Enjoy,
Balbir

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

