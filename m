Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbQKUNoq>; Tue, 21 Nov 2000 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKUNoh>; Tue, 21 Nov 2000 08:44:37 -0500
Received: from slip202-135-75-88.ca.au.ibm.net ([202.135.75.88]:5251 "EHLO
	krispykreme") by vger.kernel.org with ESMTP id <S129735AbQKUNoY>;
	Tue, 21 Nov 2000 08:44:24 -0500
Date: Wed, 22 Nov 2000 00:14:19 +1100
To: linux-kernel@vger.kernel.org
Subject: bdflush way too agressive
Message-ID: <20001122001419.E3430@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Anton Blanchard <anton@linuxcare.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The current defaults for bdflush make it start async flushing when 20% of
buffers are dirty and sync flush when 40% of buffers are dirty. I think
these defaults are way off but apparently it is intentional. (sync flushing
should be a last ditch effort when free memory is getting low and 40%
on our 2G RAM test machine is not low!).

Regardless of my opinions there remains the problem that I cannot set sane
values for these options since one is hardcoded as 2 times the other. We
should have another bdflush sysctl variable so it can be tuned (eg in
my case 90%/95%).

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
