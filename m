Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVANSGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVANSGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVANSGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:06:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35252 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261245AbVANSGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:06:00 -0500
Message-ID: <002301c4fa63$9d9d3b10$6900a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Robert Love" <rml@novell.com>, "John McCutchan" <ttb@tentacle.dhs.org>,
       "John Hawkes" <hawkes@tomahawk.engr.sgi.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com> <1105663758.6027.215.camel@localhost>  <1105666283.15782.2.camel@vertex> <1105669742.6027.243.camel@localhost>
Subject: Re: 2.6.10-mm3 scaling problem with inotify
Date: Fri, 14 Jan 2005 10:05:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Robert Love" <rml@novell.com>
...
> John Hawkes: Attached patch implements the dget() optimization in the
> same manner as dnotify.  Compile-tested but not booted.
>
> Let me know!
...
> inotify: don't do dget() unless we have to
>
>  drivers/char/inotify.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)

The patch shows a substantial 4x improvement for my specific workload (@64p),
although I can still envision workloads that will stimulate high spinlock
contention from spin_lock(&dentry->d_lock).  First things first -- let's get
this fix into the -mm tree.  Thanks!

John Hawkes

