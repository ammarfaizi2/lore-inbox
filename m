Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVLMFC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVLMFC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVLMFCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:02:55 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:42664 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932438AbVLMFCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:02:55 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com, ak@suse.de,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain 
In-reply-to: Your message of "Thu, 08 Dec 2005 14:53:56 CDT."
             <Pine.LNX.4.44L0.0512081438050.4934-100000@iolanthe.rowland.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Dec 2005 16:02:30 +1100
Message-ID: <7639.1134450150@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005 14:53:56 -0500 (EST), 
Alan Stern <stern@rowland.harvard.edu> wrote:
>The code below defines three new data structures: atomic_notifier_head,
>blocking_notifier_head, and raw_notifier_head.  The first two correspond
>to what we had in the earlier patch, and raw_notifier_head is almost the
>same as the current implementation, with no locking or protection at all.  

Acked-By: Keith Owens <kaos@sgi.com>

I do not care how this problem is fixed, I am happy with any solution that

(a) stops notify chains being racy and
(b) allows users of notify_die() to be safely unloaded.

