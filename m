Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSICXJz>; Tue, 3 Sep 2002 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSICXJz>; Tue, 3 Sep 2002 19:09:55 -0400
Received: from [209.195.52.32] ([209.195.52.32]:2257 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S318972AbSICXJy>; Tue, 3 Sep 2002 19:09:54 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 16:05:27 -0700 (PDT)
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209032148.g83LmWU14950@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44.0209031603360.1889-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> > in addition you will have lots of potential races as one system reads a
> > block of data, modifies it, then writes it while the other system does the
>
> Uh, I am confident that there can  be no races with respect to data
> writes provided I manage to make the VFS operations atomic via
> appropriate shared locking. What one has to get rid of is cached
> metadata state. I'm open to suggestions.

well you will have to change the filesystems to attempt your new atomic
VFS operations, today the kernel ext2 driver can just aquire a lock,
diddle with whatever it wants, and write the result. it doesn't do
anything that the VFS will see as atomic.

David Lang

