Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTDYUUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTDYUUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:20:22 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41366 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263957AbTDYUUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:20:16 -0400
Date: Fri, 25 Apr 2003 13:32:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: TASK_UNMAPPED_BASE & stack location
Message-ID: <459930000.1051302738@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
libraries directly above the program text? Red Hat seems to have patches to
dynamically tune it on a per-processes basis anyway ...

Moreover, can we put the stack back where it's meant to be, below the
program text, in that wasted 128MB of virtual space? Who really wants 
> 128MB of stack anyway (and can't fix their app)?

I'm sure there's some horrible reason we can't do this ... would just like
to know what it is. If it's "standards compilance" I don't really believe
it - we don't comply with the standard now anyway ...

M.

PS. Motivation is creating large shmem segments for DBs.
