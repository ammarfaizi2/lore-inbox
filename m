Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFOAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbTFOAjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:39:09 -0400
Received: from main.gmane.org ([80.91.224.249]:9921 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261651AbTFOAjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:39:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Neal Becker <nbecker@fred.net>
Subject: pty question [OT]
Date: Sat, 14 Jun 2003 20:25:52 -0400
Message-ID: <bcge5p$gkt$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose this isn't exactly specific to linux kernel.  I have some programs
running at work, each writing results to stdout.  Each is running within a
shell within some type of xterm-like device.  I want to be able to check on
the results from home.

I know if I had thought about it in advance, I could use screen, or even
xemacs/gnuclient.

I'm wondering if I can get anything by looking at /proc/pid/fd/.  
For example, I'm running top and I see:

ls -l /proc/5012/fd/
total 0
lrwx------    1 nbecker  nbecker        64 Jun 14 20:24 0 -> /dev/pts/2
lrwx------    1 nbecker  nbecker        64 Jun 14 20:24 1 -> /dev/pts/2
lrwx------    1 nbecker  nbecker        64 Jun 14 20:24 2 -> /dev/pts/2
lr-x------    1 nbecker  nbecker        64 Jun 14 20:24 3 -> /proc/uptime
lr-x------    1 nbecker  nbecker        64 Jun 14 20:24 4 -> /proc/stat
lr-x------    1 nbecker  nbecker        64 Jun 14 20:24 5 -> /proc/loadavg
lr-x------    1 nbecker  nbecker        64 Jun 14 20:24 6 -> /proc/meminfo

I guess the problem is I can't find any documentation on devpts.  Maybe if I
could find some I'd be able to figure out a device I could open to peek at
the stdout of a process?

