Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVAPS7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVAPS7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVAPS7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:59:47 -0500
Received: from tomts13.bellnexxia.net ([209.226.175.34]:14486 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262568AbVAPS7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:59:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Process system call access list.
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 16 Jan 2005 14:00:22 -0500
Message-ID: <m2wtudqjw9.fsf@sympatico.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[please CC me.]

I was looking at phrack and many of the remote exploits rely on
injecting some arbitrary code.  Generally is is something like
'exec("/bin/sh")' or something like that.

I was wondering if a section could be added to the link phase of a
user application that would keep a list/bit mask of all kernel calls
that the compiler had encountered in some section.

When the kernel loaded a process, it would keep a copy of the bit mask
and perform a comparison to see if the process was intended to make
the system call (perhaps only a sub-set of the entire system calls are
needed).

Of course, I imagine there is some reason that a process would like to
dynamically create it's own code [although it wouldn't be the
majority?], so the bit mask could be set to all ones via some linker
magic when building the user application.

Generally it would help protect against remote code injection and some
possible privilege elevation exploits by restricting system calls.  On
the down side, it is probably not fool proof and might give people a
false sense of security.  So perhaps it is not a good feature for the
kernel to have.

Sorry if this has been discussed before.  Unlike disk encryption, I
couldn't find a reference to this topic, but maybe my search was using
the wrong nomenclature.  The susinct question would be is this worth
implementing?

tia,
Bill Pringlemeir.


