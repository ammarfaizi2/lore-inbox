Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTD1Cuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTD1Cuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:50:32 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:61840 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263390AbTD1Cub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:50:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 27 Apr 2003 20:03:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <Pine.LNX.4.50.0304271957210.7601-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Apr 2003, Ulrich Drepper wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Davide Libenzi wrote:
>
> > This is very much library stuff. I don't think that saving a couple of
> > system calls will give you an edge, expecially when we're talking of
> > spawning another process. Even if the process itself does nothing but
> > return. Ulrich might be eventually interested ...
>
> POSIX has a spawn interface, see <spawn.h> on modern systems.
                                                ^^^^^^^^^^^^^^
( You want to make me pay for the last question about swapcontext in our
old glibc environment, don't you ? ;)

If I read the specification correctly, the posix_spwan() interface will
not solve scalability problems due to huge file tables. If I read it
correctly, and if you have M files currently opened and you want to
keep/dup only three files, you have to drop (M-3) close actions plus 3 dup
actions. To solve such problem you'd need a default-all-closed option plus
3 dup actions. That inside the kernel will translate in a brand new file
table plus 3 links.




- Davide

