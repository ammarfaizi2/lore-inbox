Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbVKIVmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbVKIVmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbVKIVmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:42:03 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:53146 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1161237AbVKIVmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:42:01 -0500
Date: Wed, 9 Nov 2005 13:42:00 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: openat()
In-Reply-To: <43724AB3.40309@redhat.com>
Message-ID: <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org>
References: <43724AB3.40309@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Ulrich Drepper wrote:

> Can we please get the openat() syscall implemented?  I know Linus already
> declared this is a good idea and I can only stress that it is really essential
> for some things.  It is today impossible to write correct code which uses long
> pathnames since all these operations would require the use of chdir() which
> affect the whole POSIX process and not just one thread.  In addition we have
> the reduction of race conditions.

oh sweet i've always wanted this for perf improvements in multithreaded 
programs which have to deal with lots of lookups deep in a directory tree 
(especially over NFS).

would this include other related syscalls such as link, unlink, rename, 
chown, chmod... so that the the virtualization of the "current working 
directory" concept is more complete?

-dean
