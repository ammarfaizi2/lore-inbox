Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUEJXYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUEJXYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEJXR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:17:26 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:8689 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263020AbUEJXOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:14:05 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add path-oriented proc_mkdir_path() function to /proc
Message-Id: <E1BNJyD-0001YR-IU@peregrine.corp.google.com>
From: Edward Falk <efalk@google.com>
Date: Mon, 10 May 2004 16:14:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch to allow creation of e.g. /proc/foo/bar/ with one function call.]

> Hmm.. Looks like a useful utility function (there's certainly enough deep
> trees in my /proc/sys tree), but I wonder...
> 
> 1) Do we have cases where code should be implementing "it had *better* exist"
> checks?  This may be important if an intermediate directory "should have" been
> created by sysctl or something, and has special permission needs..
> 
> 2) Alternatively, does using this open up accidental collisions where we should
> have checked something *doesnt* exist already, and complain if it does?
> 
> (Feel free to address either one by adding a "Dont do that then" comment ;)

Don't do that, then.  :)

OK, long answer:

1 & 2) are beyond the scope of my patch, but it seems to me that
additional functionality could be added -- perhaps in the form of O_CREAT,
O_EXCL flags -- if demand warranted it.  Perhaps this could be done in
a later patch?

	-ed falk, efalk@google.com
