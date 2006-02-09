Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWBISXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWBISXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWBISXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:23:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2733 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932532AbWBISXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:23:32 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: swsusp done by migration (was Re: [RFC][PATCH 1/5]
 Virtualization/containers: startup)
References: <43E38BD1.4070707@openvz.org>
	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
	<43E3915A.2080000@sw.ru>
	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
	<m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>
	<m1hd7condi.fsf@ebiederm.dsl.xmission.com>
	<1139243874.6189.71.camel@localhost.localdomain>
	<m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
	<20060208215412.GD2353@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 11:20:13 -0700
In-Reply-To: <20060208215412.GD2353@ucw.cz> (Pavel Machek's message of "Wed,
 8 Feb 2006 21:54:13 +0000")
Message-ID: <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Well, for now software suspend is done at very different level
> (it snapshots complete kernel state), but being able to use
> migration for this is certainly nice option.
>
> BTW you could do whole-machine-migration now with uswsusp; but you'd
> need identical hardware and it would take a bit long... 

Right part of the goal is with doing it as we are doing it is that we can
define what the interesting state is.

Replacing software suspend is not an immediate goal but I think it is
a worthy thing to target.  In part because if we really can rip things
out of the kernel store them in a portable format and restore them
we will also have the ability to upgrade the kernel with out stopping
user space applications...

But being able to avoid the uninteresting parts, and having the policy
complete controlled outside the kernel are the big wins we are shooting for.

Eric
