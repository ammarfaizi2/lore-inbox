Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268896AbUIQQmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268896AbUIQQmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUIQQkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:40:10 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9939 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268964AbUIQPtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:49:49 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095431960.26147.13.camel@localhost.localdomain>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
	 <1095388176.20763.29.camel@localhost>
	 <1095431960.26147.13.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Sep 2004 11:48:43 -0400
Message-Id: <1095436123.23385.182.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 15:39 +0100, Alan Cox wrote:

> Why does it have to be "a" solution not different things for different
> tasks.

I have hopes that a single solution can happily solve all the cases.  At
their core, all of these tasks are essentially the same - file change
notification - and it seems redundant to implement multiple file change
systems in the kernel.

I've looked into more "indexing" specific solutions and you see both
races and security issues when you move away from the subscribe-to-
watch-each-inode model.

That said, I personally don't have any reason for wanting a single
solution, except that because it is cleaner/simpler/smaller/etc it has a
better chance of success.  If you have code that speaks different, then
great!

	Robert Love


