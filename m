Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTEMQQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTEMQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:16:05 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33042 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262300AbTEMQQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:16:02 -0400
Date: Tue, 13 May 2003 18:27:11 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexh@ihatent.com
Subject: Re: [PATCH] Re: 2.5.69-mm4 undefined active_load_balance
Message-ID: <20030513162711.GA30804@hh.idb.hist.no>
References: <20030512225504.4baca409.akpm@digeo.com> <87vfwf8h2n.fsf@lapper.ihatent.com> <20030513001135.2395860a.akpm@digeo.com> <87n0hr8edh.fsf@lapper.ihatent.com> <20030513085525.GA7730@hh.idb.hist.no> <20030513020414.5ca41817.akpm@digeo.com> <3EC0FB9E.8030305@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC0FB9E.8030305@aitel.hist.no>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:05:18PM +0200, Helge Hafting wrote:

> Patch for the active_load_balance problem.
> It is not yet tested, it is compiling right now
> and that takes time.

Of course I missed something.  Here is a patch
that compiles and links too, when also using Andrew's
fb-logo patch.  I haven't tried booting it yet, as
it is a remote machine.

Helge Hafting


--- sched.h.orig        2003-05-13 15:45:17.000000000 +0200
+++ sched.h     2003-05-13 18:07:01.000000000 +0200
@@ -158,10 +158,8 @@
 # define CONFIG_NR_SIBLINGS 0
 #endif
 
-#ifdef CONFIG_NR_SIBLINGS
+#if CONFIG_NR_SIBLINGS
 # define CONFIG_SHARE_RUNQUEUE 1
-#else
-# define CONFIG_SHARE_RUNQUEUE 0
 #endif
 extern void sched_map_runqueue(int cpu1, int cpu2);
 

