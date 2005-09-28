Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVI1Rdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVI1Rdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVI1Rdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:33:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56032 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751114AbVI1Rdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:33:39 -0400
Date: Wed, 28 Sep 2005 10:33:12 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Simon White <s_a_white@email.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Best Kernel Timers?
In-Reply-To: <20050928093602.DFA0B8401C@ws1-5.us4.outblaze.com>
Message-ID: <Pine.LNX.4.62.0509281031340.14338@schroedinger.engr.sgi.com>
References: <20050928093602.DFA0B8401C@ws1-5.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Simon White wrote:

> Now as an alternative it is again desired that a version (although
> wont perfectly work) be available to a vanilla 2.6 kernel (possibly
> 2.4) with similiar limitations as before.  Its a shame the posix
> calls appear to not be supported in kernel for drivers so I have
> wrapped the calls for semaphores/mutexs/threads to kernel
> equivalents.

They are supported. See drivers/char/mmtimer.c for an example 
implementation.

> However I have no idea what to do for the timers.  Is there
> something suitable inkernel that would provide an async callback
> to pre-empt a realtime thread and provide better resolution than
> HZ a far amount of the time?  Or do I have to run a seperate lower
> priority busy waiting thread to wakeup the realtime one?

Yes. Provide an implementation for a posix clock like done in the mmtimer 
driver.
