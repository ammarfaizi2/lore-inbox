Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRC2PvW>; Thu, 29 Mar 2001 10:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRC2PvN>; Thu, 29 Mar 2001 10:51:13 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:48905 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S132756AbRC2PvD>; Thu, 29 Mar 2001 10:51:03 -0500
To: robert@mpe.mpg.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solved with MTRR was: ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2
In-Reply-To: <200103291534.f2TFYr700338@robert2.mpe-garching.mpg.de>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 29 Mar 2001 15:50:09 +0000
In-Reply-To: Robert Suetterlin's message of "Thu, 29 Mar 2001 17:34:53 +0200"
Message-ID: <y7r1yrgy3pq.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Suetterlin <sutter@robert2.mpe-garching.mpg.de> writes:
> 2. I was not allowed to do `base=0 size=0x400000000
> type=write-back`, because of the overlap with the memory range at
> base=0x0fb000000. 

/proc/mtrr does allow overlapping regions in some cases, but the
conditions turned out to be stricter than I remembered.  You have to
create the enclosing range first, which makes the facility useless in
this case (perhaps in all potentially useful cases).

> So what I do is only disable 3-7, and then
> base=0x400000000 size=0x400000000.

Yes, that solution should be safe.

