Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWHSJID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWHSJID (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWHSJIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:08:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:909 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751670AbWHSJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:08:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>
Subject: Re: [PATCH 4/7] proc: Make the generation of the self symlink table driven.
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
	<1155665132774-git-send-email-ebiederm@xmission.com>
	<20060819010656.e169c3b7.akpm@osdl.org>
Date: Sat, 19 Aug 2006 03:07:37 -0600
In-Reply-To: <20060819010656.e169c3b7.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 19 Aug 2006 01:06:56 -0700")
Message-ID: <m1psexum92.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 15 Aug 2006 12:05:27 -0600
> "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>
>> By not rolling our own inode we get a little more code reuse,
>> and things get a little simpler and we don't have special
>> cases to contend with later.
>
> On a standard FC5 install (which has selinux enabled) things get very ugly.
>
> udev: MAKEDEV: mkdir: file exists
>
> followed by a stream of udev errors of various sorts and then an infinite
> loop of auditd complaints about klogd and "/" and tmpfs.  Nothing makes it
> to logs because klogd itself is failing.

I'm not feeling very generous today.  I'm wondering what selinux bug
I have found now.  Without selinux everything is fine on FC5.

Any chance of a search through that patchset to see which patch selinux
trips on?

Eric


