Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSB1RYc>; Thu, 28 Feb 2002 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSB1RXy>; Thu, 28 Feb 2002 12:23:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61456 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293621AbSB1RTV>; Thu, 28 Feb 2002 12:19:21 -0500
Date: Thu, 28 Feb 2002 09:16:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: thread groups bug?
In-Reply-To: <2720.1014908983@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0202280914500.15607-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Feb 2002, David Howells wrote:
>
> If the master thread of a thread group (PID==TGID) performs an execve() then
> it is possible to end up with two or more thread groups with the same TGID.

No.

When they have the same TGID, they _are_ the same thread group.

There is absolutely _zero_ correlation between thread ID and MM. Never has
been, never will be. An execve() is a total non-event from a TGID
perspective.

If you expect POSIX behaviour, you do not do execve's from the master.
It's that simple.

(Note that if you want POSIX behaviour, you're catching execve() anyway,
so the matter is moot).

		Linus

