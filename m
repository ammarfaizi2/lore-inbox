Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUHCMto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUHCMto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUHCMto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:49:44 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9212 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265974AbUHCMtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:49:42 -0400
Subject: Re: secure computing for 2.6.7
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: chris@scary.beasts.org, Hans Reiser <reiser@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040801150119.GE6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com> <20040801102231.GB6295@dualathlon.random>
	 <Pine.LNX.4.58.0408011248040.1368@sphinx.mythic-beasts.com>
	 <20040801150119.GE6295@dualathlon.random>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1091537283.7645.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 08:48:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 11:01, Andrea Arcangeli wrote:
> Seems like a few people is interested in what you suggest above. it'd be
> very trivial to add a seccomp-mode = 2 that adds more syscalls like the
> socket syscalls like accept/sendfile/send/recv and also the open syscall
> (which means you want to use chroot still).  In the code you can see I
> wrote it so that more modes can be added freely. I mean it has some
> flexibility already.  vsftpd could enable the seccomp mode 2 on itself
> after it has initialized.

As you begin moving toward increasingly general modes of operation, and
get to the point of having to filter actual system call parameters, I
think you would be better served by using an LSM and mediating access to
the actual kernel objects.

For your own particular mode of operation, have you considered running
the untrusted code in a virtual machine, using something like Xen,
rather than trying to create a "safe" subset of kernel calls for a
single kernel instance?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

