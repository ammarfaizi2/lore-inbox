Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUHDTV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUHDTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUHDTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:21:26 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7556 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267383AbUHDTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:21:25 -0400
Subject: SCHED_BATCH and SCHED_BATCH numbering
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1091638227.1232.1750.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Aug 2004 12:50:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these going to be numbered consecutively, or might
they better be done like the task state? SCHED_FIFO is
in fact already treated this way in one place. One might
want to test values this way:

if(foo & (SCHED_ISO|SCHED_RR|SCHED_FIFO))  ...

(leaving aside SCHED_OTHER==0, or just translate
that single value for the ABI)

I'd like to see these get permenant allocations
soon, even if the code doesn't go into the kernel.
This is because user-space needs to know the values.


