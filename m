Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSGaNPO>; Wed, 31 Jul 2002 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSGaNPO>; Wed, 31 Jul 2002 09:15:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30810 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318368AbSGaNPM>; Wed, 31 Jul 2002 09:15:12 -0400
Date: Wed, 31 Jul 2002 15:19:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020731131942.GC11020@dualathlon.random>
References: <20020730214116.GN1181@dualathlon.random> <Pine.LNX.4.44L.0207302219400.23404-100000@imladris.surriel.com> <20020731013238.GJ1181@dualathlon.random> <20020731092527.A8443@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020731092527.A8443@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 09:25:27AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 31, 2002 at 03:32:38AM +0200, Andrea Arcangeli wrote:
> > disagree, merging synchronous requests would make much more sense than
> > merging asynchronous requests in the same syscall, it would make them
> > asynchronous with respect than each other without losing their global
> > synchronous behaviour w.r.t. userspace.
> 
> readv/writev..

exactly, that's the same concept even if it cannot intermix read,
writes, fsyncs and polls in the same call :).

Andrea
