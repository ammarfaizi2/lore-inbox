Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269785AbRHDEOY>; Sat, 4 Aug 2001 00:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269789AbRHDEOO>; Sat, 4 Aug 2001 00:14:14 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44373 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269785AbRHDEOC>; Sat, 4 Aug 2001 00:14:02 -0400
Date: Sat, 4 Aug 2001 00:14:05 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032045280.15155-200000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108040012020.14842-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:

> For nicer interactive behaviour while flushing things out, the
> inode_fsync() thing should really use "write_locked_buffers()". That's a
> separate patch, though.

Mildly better interactive performance, but absolutely horrid io
throughput.  The system degrades to the point where blocks are getting
flushed to disk at ~2MB/s vs the 80MB/s its capable of.  Not instrumented
since I'm trying to actually relax.

		-ben

