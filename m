Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTEHCj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTEHCj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:39:57 -0400
Received: from zero.aec.at ([193.170.194.10]:24595 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262032AbTEHCj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:39:56 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: garbled oopsen
From: Andi Kleen <ak@muc.de>
Date: Thu, 08 May 2003 04:49:28 +0200
In-Reply-To: <20030508015008$481c@gated-at.bofh.it> (Andrew Morton's message
 of "Thu, 08 May 2003 03:50:08 +0200")
Message-ID: <m34r46dufb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030508011013$3d80@gated-at.bofh.it>
	<20030508015008$481c@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

>> Can these be cleaned up in any reasonable way?
>
> It needs some additional spinlock in there.  People have moaned for over a
> year, patches have been floating about but nobody has taken the time to
> finish one off and submit it.

I considered it for x86-64 and even implemented it, but never submitted
in fear of deadlocks e.g. when an oops recurses. For this a 
spinlock_timeout() would be useful. Print anyways when you cannot get the
lock in a second or two.

-Andi
