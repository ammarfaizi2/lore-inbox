Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWCTQ4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWCTQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWCTQ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:56:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15014 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965246AbWCTQ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:56:18 -0500
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       akpm@osdl.org, ebiederm@xmission.com, janak@us.ibm.com,
       viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de, paulus@samba.org,
       mtk-manpages@gmx.net
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
References: <787b0d920603192045y76e99e32p4ddde31961f80bb9@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Mar 2006 09:52:58 -0700
In-Reply-To: <787b0d920603192045y76e99e32p4ddde31961f80bb9@mail.gmail.com> (Albert
 Cahalan's message of "Sun, 19 Mar 2006 23:45:52 -0500")
Message-ID: <m1oe01vz11.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> The unshare() syscall is in fact a clone() syscall minus one
> CLONE_* flag that is normally implied: CLONE_TASK_STRUCT.
> (conceptually -- it has no name because it is always implied)
>
> We already have one flag with inverted action: CLONE_NEWNS.
> Adding another such flag (for the task struct) makes sense.
> The new system call is thus not needed at all.
>
> Suggested names: CLONE_NO_TASK, CLONE_SAMETASK, CLONE_SHARETASK

The practical issue there is that even in the best case the implementations
are enough different that it probably would not make a lot of sense.

Eric

