Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135989AbRDTS6y>; Fri, 20 Apr 2001 14:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135987AbRDTS6p>; Fri, 20 Apr 2001 14:58:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:49501 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135978AbRDTS6b>; Fri, 20 Apr 2001 14:58:31 -0400
Date: Fri, 20 Apr 2001 20:58:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dhowells@redhat.com,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [andrea@suse.de: Re: generic rwsem [Re: Alpha "process table hang"]]
Message-ID: <20010420205812.C32159@athlon.random>
In-Reply-To: <torvalds@transmeta.com> <24526.987755027@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24526.987755027@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Fri, Apr 20, 2001 at 09:23:47AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 09:23:47AM +0100, David Howells wrote:
> Andrea seems to have changed his mind on the non-inlining in the generic case.

I changed my mind because if you benchmark the fast path you will do it without
running out of icache (basically only down_* and up_* will be in the icache
during the tight loop). And either ways shouldn't make a measurable difference
in a real life benchmark.

Andrea
