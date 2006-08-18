Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWHRVjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWHRVjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWHRVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:39:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:25359 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751487AbWHRVjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:39:15 -0400
Date: Fri, 18 Aug 2006 17:39:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kai Petzke <wpp@marie.physik.tu-berlin.de>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Complaint about return code convention in queue_work() etc.
Message-ID: <Pine.LNX.4.44L0.0608181730510.5732-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to lodge a bitter complaint about the return codes used by 
queue_work() and related functions:

	Why do the damn things return 0 for error and 1 for success???
	Why don't they use negative error codes for failure, like 
	everything else in the kernel?!!

I've tripped over this at least twice, and on each occasion spent a
considerable length of time trying to track down the problem.

If nobody objects, I'll write a patch to change the convention for the
return values.  It doesn't matter how many places those routines are
called from; it'll be worth it.

Alan Stern

