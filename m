Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270980AbRHOAan>; Tue, 14 Aug 2001 20:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270974AbRHOAaX>; Tue, 14 Aug 2001 20:30:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:841 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270969AbRHOAaQ>; Tue, 14 Aug 2001 20:30:16 -0400
Date: Wed, 15 Aug 2001 02:30:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
Message-ID: <20010815023018.H4304@athlon.random>
In-Reply-To: <20010814.163804.66057702.davem@redhat.com> <3B79BA07.B57634FD@sun.com> <20010815021110.F4304@athlon.random> <20010814.171609.75760869.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010814.171609.75760869.davem@redhat.com>; from davem@redhat.com on Tue, Aug 14, 2001 at 05:16:09PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 05:16:09PM -0700, David S. Miller wrote:
> Yeah, the check can be removed, but anyone who cares about
> performance won't pass in huge arrays of -1 entries if only
> the low few pollfd entries are actually useful.

yes, on the same lines I'm not sure who needs the -1 entries in first
place since one of the major points of poll is to avoid useless browse
of non interesting entries. I'm scared people uses poll just to
workaround the 1024 bit limit on the fdset structures in glibc and to
generate arrays larger than 1024. I hope it's just a resource management
issue, where only a few entries are sometime set to -1 and so they can
avoid to duplicate the polltable for very minor difference in their
utilization or for slow path cases.

Andrea
