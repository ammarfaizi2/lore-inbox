Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWHHVk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWHHVk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHHVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:40:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:61948 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965045AbWHHVk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:40:28 -0400
Date: Tue, 8 Aug 2006 17:40:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org, pavel@suse.cz,
       ncunningham@linuxmail.org
Subject: swsusp and suspend2 like to overheat my laptop
Message-ID: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few months ago, I installed suspend2 on my laptop.  It worked great for
a few days, when suddenly my laptop started to get very hot and the fan
costantly went off, and then I started getting these:

---
Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
localhost kernel: CPU0: Temperature above threshold

Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
localhost kernel: CPU1: Temperature above threshold


Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
localhost kernel: CPU0: Running in modulated clock mode

Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
localhost kernel: CPU1: Running in modulated clock mode
---

I even posted once since I thought I found the problem, but I was wrong.
So I decided to remove Suspend2 and go back to the normal kernel.

Recently, I've decided to try out swsusp.  Well, it has been working fine
for almost a week now.  But unfortunately, I just started to have my fan
go off constantly, and I'm getting the above messages again (hence why
the date on the messages is today). Checking out the temp, it's going into
the high 70C. That's not too bad, but it only happens when suspending
every night instead of shutting down.

This is a Thinkpad G41, with a P4HT and this is a unmodified 2.6.18-rc2
kernel.  I guess I'll have to start shutting down again, and only suspend
every so often.  But just thought I'd let the people of knowledge know.

-- Steve

