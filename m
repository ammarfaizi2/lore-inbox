Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJBAi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJBAi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:38:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:20680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbTJBAi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:38:27 -0400
Date: Wed, 1 Oct 2003 17:38:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <perfctr-devel@lists.sourceforge.net>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <1065051745.736.39.camel@cube>
Message-ID: <Pine.LNX.4.44.0310011717180.6077-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Oct 2003, Albert Cahalan wrote:
> 
> It certainly seems to me that the intent of /proc/self is
> to point to a "process", which is a tgid in kernel terms.

My argument against that is that it actually loses information. Now there 
is no way to easily look up the current thread stuff.

If /proc/self points to a thread, it's easy to look up the process with a 
"/proc/self/../..".

So in that sense it's a bad interface to point to the process, not the 
thread.

> I think there is something clearly defective about having
> the /proc/self link point to a hidden directory.

It's not hidden. It would just point to the real thread directory..

		Linus

