Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbTJBE7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTJBE7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:59:23 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:13956
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263240AbTJBE7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:59:04 -0400
Message-ID: <3F7BB073.60509@redhat.com>
Date: Wed, 01 Oct 2003 21:58:27 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>	 <3F7B9CF9.4040706@redhat.com> <1065067968.741.75.camel@cube>
In-Reply-To: <1065067968.741.75.camel@cube>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> In that case, don't you already have a severe mess?
> [...]

That's all completely up to whoever decides to use this combination of
CLONE_* flags.  It might mean that SIGIO cannot be used and that fuser
cannot be used.  But so what?  That might be acceptable in that
situation.  What isn't acceptable is providing wrong information to the
program.  And this is not using a pointer to the kernel thread does.

Of course it could be redefined as "point to the process group leader"
but I'm not sure whether this and introducing "/proc/task" or so is
worth the trouble.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

