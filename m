Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVGaQ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVGaQ3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVGaQ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:29:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5622 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261814AbVGaQ3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:29:02 -0400
Subject: hashed spinlocks
From: Daniel Walker <dwalker@mvista.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42E9E91B.9050403@cosmosbay.com>
References: <20050728090948.GA24222@elte.hu>
	 <200507281914.j6SJErg31398@unix-os.sc.intel.com>
	 <20050729070447.GA3032@elte.hu> <20050729070702.GA3327@elte.hu>
	 <42E9E91B.9050403@cosmosbay.com>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 09:27:55 -0700
Message-Id: <1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>From 2.6.13-rc4 this hunk

+#else
+# define rt_hash_lock_addr(slot) NULL
+# define rt_hash_lock_init()
+#endif

Doesn't work with the following,

+               spin_unlock(rt_hash_lock_addr(i));


Cause your spin locking a NULL .. I would give a patch, but I'm not sure
what should be done in this case..

Daniel

