Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVFQPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVFQPoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVFQPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:44:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:15514 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262001AbVFQPog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:44:36 -0400
Subject: Re: [patch] inotify, improved.
From: Robert Love <rml@novell.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <42B2EE31.9060709@nortel.com>
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy>  <42B227B5.3090509@yahoo.com.au>
	 <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy>
	 <42B2EE31.9060709@nortel.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 11:44:38 -0400
Message-Id: <1119023078.3949.115.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 09:37 -0600, Chris Friesen wrote:

Hi, Chris.

> On a newsgroup someone was using inotify, but was asking if there was 
> any way to also determine which process/user had caused the notification.
> 
> Is this something that would make sense (as an optional bit of 
> information) in inotify?

It is definitely something that could be added, technically speaking.

I have been hesitant, though.  I do not want feature creep to be a
deterrent to acceptance into the Linux kernel.  I also think that there
could be arguments about security.  Sending the event is one thing,
telling which pid (and thus what user, etc.) caused the event is
another.  For example, we can make the argument that read rights on a
file are tantamount to the right to receive a read event.  But can we
say that read rights are enough for a unprivileged user to know that
root at pid 820 is writing the file?  I don't know.

I'd add it if there were consensus.  I don't know that it makes sense,
though.

	Robert Love


