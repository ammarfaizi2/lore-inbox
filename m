Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWDJGx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWDJGx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWDJGx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:53:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52902 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751043AbWDJGx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:53:28 -0400
Date: Mon, 10 Apr 2006 08:53:32 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumpable tasks and ownership of /proc/*/fd
Message-ID: <20060410065332.GD16588@pasky.or.cz>
References: <20060408120815.GB16588@pasky.or.cz> <m17j5yhtp4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j5yhtp4.fsf@ebiederm.dsl.xmission.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 10, 2006 at 07:43:03AM CEST, I got a letter
where "Eric W. Biederman" <ebiederm@xmission.com> said that...
> Speaking of things why does the *at() emulation need to touch
> /proc/self/fd/*?  I may be completely dense but if the practical
> justification for allowing access to /proc/self/fd/ is that we
> already have access then we shouldn't need /proc/self/fd.
> 
> I suspect this a matter of convenience where you are prepending
> /proc/self/fd/xxx/ to the path before you open it instead of calling
> fchdir openat() and the doing fchdir back.  Have I properly guessed
> how the *at() emulation works?

Ok, now I'm not completely following you. Only i386 and x86_64 appears
to provide the openat() syscall (only in new kernels, furthermore) and
glibc otherwise emulates openat(n, "relpath") with
open("/proc/self/fd/<n>/relpath"). I don't know of any other way how to
emulate it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
