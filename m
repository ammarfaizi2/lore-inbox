Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVCJEhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVCJEhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVCJEe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:34:26 -0500
Received: from peabody.ximian.com ([130.57.169.10]:936 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262424AbVCJEbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:31:16 -0500
Subject: Re: sched_setscheduler and pids/threads
From: Robert Love <rml@novell.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970503092012475049db@mail.gmail.com>
References: <21d7e9970503092012475049db@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 23:33:50 -0500
Message-Id: <1110429230.28072.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 15:12 +1100, Dave Airlie wrote:

> In 2.6 all my threads appear as a single PID,if I use chrt -p <pid>
> will it set the scheduling priority for my main thread or for all
> threads in the application?

For just the main thread (or the thread of whatever PID you give).  You
need to set the PID of each thread individually.  The "everything
appears as a single PID" is just an elaborate parlor trick.  Wool pulled
over your eyes.

> Can I used the thread IDs from /proc/<pid>/task/ to chrt the other
> threads in my app to different priorities?

You can use the PID's in /proc/<pid>/task/, yes.

Or you can just set the PID of the main thread before it starts other
threads, or use chrt to launch the program, or use chrt to set the PID
of a shell script that starts the application:  Scheduler properties are
inherited.

Best,

	Robert Love


