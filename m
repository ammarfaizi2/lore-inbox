Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFSSEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFSSEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVFSSEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:04:53 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:17584 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261270AbVFSSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:04:51 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6.12] XFS: Undeletable directory
Date: Sun, 19 Jun 2005 19:04:49 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506191904.49639.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,

I've had some XFS troubles today, and after cleaning up with xfs_repair and so 
I'm stuck with one undeletable directory in /lost+found:

precious:/lost+found# ls -l
total 8
drwxrwxrwx  2 root root 8192 Jun 19  2005 4207214
precious:/lost+found# rm -r 4207214
rm: cannot remove directory `4207214': Directory not empty
precious:/lost+found# ls -l 4207214/
total 0
precious:/lost+found# 

So there's one dir 4207214 there, and i can rename it and whatever, just not 
remove it.

xfs_repair didn't solve the problem.

Any ideas?

Thanks,

Jan
-- 
    ***
  *******
 *********
 ****** Confucious say: "Is stuffy inside fortune cookie."
  *******
    ***
