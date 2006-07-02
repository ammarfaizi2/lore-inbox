Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWGBSv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWGBSv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWGBSv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:51:29 -0400
Received: from kappa.thewebhostingserver.com ([69.93.0.202]:44459 "EHLO
	kappa.thewebhostingserver.com") by vger.kernel.org with ESMTP
	id S932708AbWGBSv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:51:28 -0400
From: Ian Turner <vectro@vectro.org>
To: linux-kernel@vger.kernel.org
Subject: waiting for MNT_DETACH
Date: Sun, 2 Jul 2006 14:51:24 -0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607021451.24595.vectro@vectro.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - kappa.thewebhostingserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - vectro.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I administer a two-node high-availability cluster using DRBD and heartbeat. 
One of my concerns is that at failover time, the replicated filesystem might 
be in use. I can stop the official services that use the filesystem, but some 
other transient scripts might have reason to probe it for a second or two.

umount -l seems like the answer to this question, in that one can ensure no 
new accesses will be made to the filesystem, while those that exist can take 
their time to finish. The catch is, there does not appear to be a way to tell 
if the unmount has really completed or not.

So, here's the question: Is there a way to check if a call to umount2(..., 
MNT_DETACH) has completed or not?

Thanks,

--Ian Turner
