Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132727AbRDNCwz>; Fri, 13 Apr 2001 22:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRDNCwo>; Fri, 13 Apr 2001 22:52:44 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:12539 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132727AbRDNCw3>;
	Fri, 13 Apr 2001 22:52:29 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <Pine.LNX.4.31.0104131925370.11761-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 13 Apr 2001 19:52:22 -0700
In-Reply-To: Linus Torvalds's message of "Fri, 13 Apr 2001 19:29:20 -0700 (PDT)"
Message-ID: <m3ae5kkxax.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> spawn() is trivial to implement if you want to. I don't think it's all
> that much more interesting than vfork()+execve(), though.

spawn() (actually posix_spawn) is currently implemented in the libc.
If anybody for whatever reason thinks it is necessary to implement
this in the kernel look at the interface.  It is really only
interesting for systems with limited VMs but it would be trivial to
add another flag which allow different scheduling characteristics
which some people apparently want.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
