Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVCNDsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVCNDsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVCNDsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:48:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:158 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261917AbVCNDsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:48:10 -0500
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: rene.scharfe@lsrfire.ath.cx, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Content-Type: text/plain
Date: Sun, 13 Mar 2005 22:34:11 -0500
Message-Id: <1110771251.1967.84.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, folks, another try to enhance privacy by hiding
> process details from other users.  Why not simply use
> chmod to set the permissions of /proc/<pid> directories?
> This patch implements it.
>
> Children processes inherit their parents' proc
> permissions on fork.  You can only set (and remove)
> read and execute permissions, the bits for write,
> suid etc. are not changable.  A user would add
>
>         chmod 500 /proc/$$
>
> or something similar to his .profile to cloak his processes.
>
> What do you think about that one?

This is a bad idea. Users should not be allowed to
make this decision. This is rightly a decision for
the admin to make.

Note: I'm the procps (ps, top, w, etc.) maintainer.

Probably I'd have to make /bin/ps run setuid root
to deal with this. (minor changes needed) The same
goes for /usr/bin/top, which I know is currently
unsafe and difficult to fix.

Let's not go there, OK?

If you restricted this new ability to root, then I'd
have much less of an objection. (not that I'd like it)



