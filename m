Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268391AbTCCFz3>; Mon, 3 Mar 2003 00:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268396AbTCCFz3>; Mon, 3 Mar 2003 00:55:29 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:47310 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S268391AbTCCFz3>;
	Mon, 3 Mar 2003 00:55:29 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303030605.h2365oK08706@csl.stanford.edu>
Subject: Re: [CHECKER] potential deadlocks
To: akpm@digeo.com (Andrew Morton)
Date: Sun, 2 Mar 2003 22:05:50 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030302212500.72fe9b87.akpm@digeo.com> from "Andrew Morton" at Mar 02, 2003 09:25:00 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are some real ones there.  The ones surrounding lock_kernel() and
> semaphores are false positives.
> 
> lock_kernel() is special, in that the lock is dropped when the caller
> performs a voluntary context switch.  So there are no ordering requirements
> between lock_kernel and the sleeping locks down(), down_read(), down_write().

Ah.  I actually knew that.  Embarassing.  Thanks for pointing it out;
I'll make the change.

BTW, are there known deadlocks (harmless or otherwise)?  Debugging
the checker is a bit hard since false negatives are silent...

Dawson
