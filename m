Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTJBDfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 23:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTJBDfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 23:35:55 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41859
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263221AbTJBDfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 23:35:54 -0400
Message-ID: <3F7B9CF9.4040706@redhat.com>
Date: Wed, 01 Oct 2003 20:35:21 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030913 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I think /proc/self most likely _should_ point into the thread, not the 
> task. 

As much as I want to not see this, I fear I have to agree.

There is, for instance, no guarantee that all CLONE_THREAD clones also
have CLONE_FILES set.  Then using /proc/self/%d for some thread-local
file descriptor will return the process group leaders file descriptor,
not the own.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

