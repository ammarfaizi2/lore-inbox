Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTGLF11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 01:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269986AbTGLF11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 01:27:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269987AbTGLF1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 01:27:24 -0400
Date: Fri, 11 Jul 2003 22:42:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: utimes/futimes/lutimes syscalls
Message-Id: <20030711224210.6fee6a73.akpm@osdl.org>
In-Reply-To: <3F0F9B0C.10604@redhat.com>
References: <3F0F9B0C.10604@redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> If
>  there are filesystems which store the sub-seconds on disk I think this
>  is necessary since otherwise all kinds of programs (including archives)
>  cannot be written correctly.  If the sub-seconds only live in memory I
>  still think it would be good to have the syscalls but it would not be
>  that urgent.

XFS (at least) stores nanoseconds on disk.  So yes, I think we should make
this change.
