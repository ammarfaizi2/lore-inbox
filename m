Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVDDWVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVDDWVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDDWVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:21:23 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:65470 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261434AbVDDWVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:21:05 -0400
Subject: Re: [patch] inotify 0.22
From: John McCutchan <ttb@tentacle.dhs.org>
To: Dale Blount <linux-kernel@dale.us>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1112647855.520.20.camel@dale.velocity.net>
References: <1112644936.6736.7.camel@betsy>
	 <1112647855.520.20.camel@dale.velocity.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Apr 2005 18:21:22 -0400
Message-Id: <1112653282.11281.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.1, Antispam-Data: 2005.4.4.13
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:50 -0400, Dale Blount wrote:
> Will inotify watch directories recursively?  A quick browse through the
> source doesn't look like it, but I very well could be wrong.  Last I
> checked, dnotify did not either.  I am looking for a way to synchronize
> files in as-real-as-possible-time when they are modified.  The ideal
> implementation would be a kernel "hook" like d/inotify and a client
> application that watches changes and copies them to a remote server for
> redundancy purposes.   A scheduled rsync works decently, but has a lag
> time of 2-3 (or more) hours on certain files on a large filesystem.
> Will inotify work for this, or does someone else have another
> recommended solution to the problem?

This problem is solved really well by inotify. But inotify will not
watch directories recursively for you. You can easily spider your way
down the path yourself adding a watch for each directory you encounter.
This is how beagle works, which has the same needs as your problem.

-- 
John McCutchan <ttb@tentacle.dhs.org>
