Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWFVD1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWFVD1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWFVD1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:27:36 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:23290 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751546AbWFVD1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:27:35 -0400
Date: Wed, 21 Jun 2006 23:27:33 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Mail-followup-to: Andrew Morton <akpm@osdl.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <20060622032733.GA5158@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

subj.

I've got a lot of BUG's during the boot and eventually box locked up.
SYS-RQ worked. Unfortunately none of these errors did make it to log files,
so I cannot provide the backtraces.

But reverting last 4 patches of reiserfs-changes series, namely

reiserfs-reorganize-bitmap-loading-functions.patch
reiserfs-on-demand-bitmap-loading.patch
reiserfs-on-demand-bitmap-loading-fix.patch
reiserfs-use-generic_file_open-for-open-checks.patch

fixed the problem for me.

I'm running 32 bit kernel on AMD64x2 w/ HIGHMEM,SMP,PREEMPT enabled

Hope you will find this report useful (sorry for the absence of the
backtrace though)
Please let me know if you want me to try some patches.

Thank you,
	Nick Orlov.

P.S. I'm on somewhat tough schedule during weekdays and I wont be able
to try the patches till tomorrow (Jun 24th) night.

-- 
With best wishes,
	Nick Orlov.

