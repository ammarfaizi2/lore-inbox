Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUHCDzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUHCDzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 23:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUHCDzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 23:55:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:54413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264961AbUHCDzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 23:55:23 -0400
Date: Mon, 2 Aug 2004 20:53:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler
 Evaluation
Message-Id: <20040802205332.3413cd6d.akpm@osdl.org>
In-Reply-To: <410EDBF5.40205@bigpond.net.au>
References: <2oEEn-197-9@gated-at.bofh.it>
	<m3isc1smag.fsf@averell.firstfloor.org>
	<410EDBF5.40205@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > Have you considered submitting one to -mm* for wider testing?
> 
>  I've made patches available for 2.6.8-rc2-mm1 and I'll provide them for 
>  mm2 as soon as possible.  Is there something else I should be doing?

I'll probably drop staircase soon, give nicksched a whizz for a couple of
cycles.  You're welcome to join the queue ;)

But let me re-repeat again that CPU scheduler problems tend to take a
_long_ time to turn up - you make some change and two months later some
person with a weird workload on expensive hardware hits a nasty corner
case.  So I do think that we'd have to hit a nasty problem with the current
scheduler to go making deep changes.

Although most of the fragility has been in CPU/node/HT balancing rather
than in the timeslice allocation area.  I assume you're not touching the
former.  It's the desktop users who seem to be more affected by the
timeslice allocation algorithms, and the testing turnaround is much faster
there.

