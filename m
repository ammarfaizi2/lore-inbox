Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJ2LML>; Tue, 29 Oct 2002 06:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJ2LML>; Tue, 29 Oct 2002 06:12:11 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:30222 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S261531AbSJ2LMK>; Tue, 29 Oct 2002 06:12:10 -0500
From: Chris Evans <chris@scary.beasts.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Reply-To: Chris Evans <chris@scary.beasts.org>
Cc: chris@scary.beasts.org, linux-kernel@vger.kernel.org, drepper@redhat.com
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com> <87elaanlhx.fsf@goat.bogus.local> <877kg2njbi.fsf@goat.bogus.local>
In-Reply-To: <877kg2njbi.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 217.163.5.253
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
Message-Id: <E186UO6-0000sD-00@sphinx.mythic-beasts.com>
Date: Tue, 29 Oct 2002 11:18:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quoting Olaf Dietsche
<olaf.dietsche#list.linux-kernel@t-online.de>:

> I just downloaded glibc 2.3.1 and would say you can
subvert a
> privileged executable with LD_PRELOAD. There's no
mention of
> PR_GET_DUMPABLE anywhere and __libc_enable_secure is
set according to
> some euid/egid tests.

In theory you should be able to just replace the
__libc_enable_secure check with

__libc_enable_secure = !prctl(PR_GET_DUMPABLE);

i.e. let the kernel handle the logic of whether a
process is running privileged.If we duplicate it
between kernel and libc, we'll get security bugs.

Cheers
Chris

