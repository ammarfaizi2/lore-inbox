Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425011AbWLCHIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425011AbWLCHIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 02:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425012AbWLCHIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 02:08:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:10420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1425011AbWLCHIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 02:08:34 -0500
Date: Sun, 3 Dec 2006 00:08:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: <Aucoin@Houston.RR.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
Message-Id: <20061203000857.af758c33.akpm@osdl.org>
In-Reply-To: <200612030616.kB36GYBs019873@ms-smtp-03.texas.rr.com>
References: <200612030616.kB36GYBs019873@ms-smtp-03.texas.rr.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 3 Dec 2006 00:16:38 -0600 "Aucoin" <Aucoin@Houston.RR.com> wrote:
> I set swappiness to zero and it doesn't do what I want!
> 
> I have a system that runs as a Linux based data server 24x7 and occasionally
> I need to apply an update or patch. It's a BIIIG patch to the tune of
> several hundred megabytes, let's say 600MB for a good round number. The
> server software itself runs on very tight memory boundaries, I've
> preallocated a large chunk of memory that is shared amongst several
> processes as a form of application cache, there is barely 15% spare memory
> floating around.
> 
> The update is delivered to the server as a tar file. In order to minimize
> down time I untar this update and verify the contents landed correctly
> before switching over to the updated software.
> 
> The problem is when I attempt to untar the payload disk I/O starts caching,
> the inactive page count reels wildly out of control, the system starts
> swapping, OOM fires and there goes my 4 9's uptime. My system just suffered
> a catastrophic failure because I can't control pagecache due to disk I/O.

kernel version?

> I need a pagecache throttle, what do you suggest?

Don't set swappiness to zero...   Leaving it at the default should avoid
the oom-killer.
