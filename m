Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267150AbUBMSUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267144AbUBMSUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:20:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25574 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267150AbUBMSUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:20:46 -0500
Date: Fri, 13 Feb 2004 18:20:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail (maps "deleted")
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310F0B9@stca204a.bus.sc.rolm.com>
Message-ID: <Pine.LNX.4.44.0402131817280.5718-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Bloch, Jack wrote:
> I am running a 2.4.19 Kernel and have a problem where a process is using the
> up to the 0xC0000000 of space. It is no longer possible for this process to
> get any more memory vi mmap or via shmget. However, when I dump the
> /procs/#/maps file, I see large chunks of memory deleted. i.e this should be
> freely available to be used by the next call. I do not see these addresses
> get re-used. The maps file is attached.

You mean, for example,
bee13000-bee2c000 rw-s 00000000 00:05 7405782    /SYSVa8020046 (deleted)
?

It's not the memory which has been "(deleted)", that's still filling your
virtual address space.  It means that shared memory objects /SYSVxxxxxxxx
are not really there on your filesystem, and so are displayed as deleted:
an mmapping of an unlinked file is shown that way.

Hugh


