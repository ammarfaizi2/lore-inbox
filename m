Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTJCAlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTJCAlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:41:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:36301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263562AbTJCAlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:41:13 -0400
Date: Thu, 2 Oct 2003 17:40:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: Ulrich Drepper <drepper@redhat.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <1065139380.736.109.camel@cube>
Message-ID: <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Oct 2003, Albert Cahalan wrote:
> 
> No. I mean "ban" like we ban CLONE_THREAD w/o CLONE_DETACHED.

No. Let's not do that.

We ban only things that do not make sense. That was true of trying to 
share signal handlers with different address spaces. But it is _not_ true 
of having separate file descriptors for different threads.

I don't imagine anybody cares _that_ deeply about fuser that it can't 
afford to recurse into thread directories.

And it may or may not make sense to not have a "/proc/<nn>/task/<yy>/fd"
directory at all if the thread shares file descriptors with the thread 
group leader. That would be a fairly easy optimization.

		Linus

