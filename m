Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVIYUmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVIYUmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVIYUmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 16:42:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15580 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932177AbVIYUmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 16:42:45 -0400
Subject: Re: [PATCH 1/4] atomic_cmpxchg and friends
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4334BCF3.1010908@yahoo.com.au>
References: <4334BCF3.1010908@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Sep 2005 22:09:31 +0100
Message-Id: <1127682571.1168.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old,
new))
+

Not all X86 has cmpxchg so the code there won't compile for all cases.

