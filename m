Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVANSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVANSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVANSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:13:56 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29630 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261153AbVANSNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:13:54 -0500
Subject: Re: 2.6.10-mm3 scaling problem with inotify
From: Robert Love <rml@novell.com>
To: John Hawkes <hawkes@sgi.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <002301c4fa63$9d9d3b10$6900a8c0@comcast.net>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com>
	 <1105663758.6027.215.camel@localhost>  <1105666283.15782.2.camel@vertex>
	 <1105669742.6027.243.camel@localhost>
	 <002301c4fa63$9d9d3b10$6900a8c0@comcast.net>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 13:15:49 -0500
Message-Id: <1105726549.6027.268.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 10:05 -0800, John Hawkes wrote:

> The patch shows a substantial 4x improvement for my specific workload (@64p),
> although I can still envision workloads that will stimulate high spinlock
> contention from spin_lock(&dentry->d_lock).  First things first -- let's get
> this fix into the -mm tree.  Thanks!

Glad it worked!

Does the spin_lock() show up in dnotify's code path?  It is getting
called, unconditionally, there, too.

	Robert Love


