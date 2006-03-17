Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752567AbWCQIhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbWCQIhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbWCQIhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:37:07 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:4783 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752567AbWCQIhF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:37:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NgbYSbkeOrSr+j8N8HFOVa5DhAt+ScbxWLsvWXinRDwaadzKEx79YmZcLy2WcO7AcoJNoS/cTR/ke0EINrjFbLT7uy9+AB3k5/MkK41jJxjwv3RT9bGRAZQi7sGm/LQXS3S2mgkVqqCdYvupiqCz3xNe1fPOt5HWofxlHIQQxZM=
Message-ID: <9fda5f510603170037v41d273c5naf36776e6f03246e@mail.gmail.com>
Date: Fri, 17 Mar 2006 00:37:04 -0800
From: "Pradeep Vincent" <pradeep.vincent@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Priority in Memory management
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried searching for discussions related to this but in vain A
significant number of servers running Linux come under the category of
"Caching Servers". These servers usually try to server data either
from RAM or disk sub-systems and for obvious reasons want to serve as
much data as possible from RAM. Even if the dataset is comparable to
RAM size, other bon-performance critical activities on the system
(such as logging, log rotation/compression, remote performance
monitors, application code updates, security related searches )
disturb the cache hit ratio.

Mlocking the dataset is one option. Using fadvise/O_STREAM for
everything else is another option - but this doesn't address all the
cases.

Instead of locking out all memory, being able to set priorities for
virtual memory regions comes across as a better idea. This way if the
system really really needs memory, kernel can reclaim the cache pages
but not just because somebody is writing something and it might seem
fair to reclaim the dataset cache.


Has this come up in the past. Any history at all - I am all ears for
ideas and concerns.

Thanks,

Pradeep Vincent
