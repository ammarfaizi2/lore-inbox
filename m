Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUDMFeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUDMFeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:34:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:7845 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263365AbUDMFeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:34:36 -0400
Message-ID: <407B7BDE.5030002@colorfullife.com>
Date: Tue, 13 Apr 2004 07:34:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAT support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Terence,

in your patch, you write
+/* Here is the PAT's default layout on ia32 cpus when we are done.
+ * PAT0: Write Back
+ * PAT1: Write Combine
+ * PAT2: Uncached
+ * PAT3: Uncacheable
+ * PAT4: Write Through
+ * PAT5: Write Protect
+ * PAT6: Uncached
+ * PAT7: Uncacheable

Is that layout possible?
There is an errata in the B2 and C1 stepping of the Pentium 4 cpus that 
results in incorrect PAT numbers: the highest bit is ignored by the CPU 
under some circumstances. There's a similar errata (E27) that affects 
all Pentium 3 cpus: The highest bit is always ignored.
I think we need a fallback to 4 PAT entries.

--
    Manfred

