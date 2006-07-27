Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWG0NMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWG0NMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWG0NMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:12:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35241 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161049AbWG0NMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:12:37 -0400
Date: Thu, 27 Jul 2006 06:12:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Should cpuset ABBA deadlock fix be in 2.6.18-rc2-mmx?
Message-Id: <20060727061232.044fc927.pj@sgi.com>
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to encourage including the patch:

  Cpuset: fix ABBA deadlock with cpu hotplug lock

in 2.6.18-rc2-mmx.  This patch was sent to lkml,
copied to akpm, 14 July.  It was sent again to lkml,
in response to a request for a copy from Linus, on
23 July, copied again to akpm.

Granted, the case for including it is not absolute.

The fix is simple enough and fixes a definite deadlock,
as verified by testing results on the system that was
seeing this deadlock.

However ... only one system, world-wide, has the magic
workload to provoke this deadlock, so far.  And it involves
the cpu hotplug lock, which perhaps Linus would like to
nuke entirely.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
