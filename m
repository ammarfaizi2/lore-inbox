Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTJBIqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJBIqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:46:31 -0400
Received: from news.cistron.nl ([62.216.30.38]:27664 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263279AbTJBIqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:46:30 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Thu, 2 Oct 2003 08:46:29 +0000 (UTC)
Organization: Cistron Group
Message-ID: <blgol5$vd0$1@news.cistron.nl>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org> <3F7B9CF9.4040706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1065084389 32160 62.216.29.200 (2 Oct 2003 08:46:29 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F7B9CF9.4040706@redhat.com>,
Ulrich Drepper  <drepper@redhat.com> wrote:
>Linus Torvalds wrote:
>
>> I think /proc/self most likely _should_ point into the thread, not the 
>> task. 
>
>As much as I want to not see this, I fear I have to agree.
>
>There is, for instance, no guarantee that all CLONE_THREAD clones also
>have CLONE_FILES set.  Then using /proc/self/%d for some thread-local
>file descriptor will return the process group leaders file descriptor,
>not the own.

How about use /proc/self/task/self/fd/%d if /proc/self/task/self
exists, /proc/self/fd/%d otherwise ?

Mike.

