Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276966AbRJCUQe>; Wed, 3 Oct 2001 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276967AbRJCUQY>; Wed, 3 Oct 2001 16:16:24 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:65235 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S276966AbRJCUQF>; Wed, 3 Oct 2001 16:16:05 -0400
Date: Wed, 3 Oct 2001 22:06:58 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS data corruption in very simple configuration
In-Reply-To: <20011003171703.B5209@redhat.com>
Message-ID: <Pine.LNX.4.33.0110032202560.26021-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Stephen C. Tweedie wrote:

> ext3 with ordered data writes has performance nearly up to the level
> of the fast-and-loose writeback mode for most workloads, and still
> avoids ever exposing stale disk blocks after a crash.
What if the machine crashes with parts of the data blocks written to
disk, before the commit block gets submitted to the drive?

The journal will tell us that the write transaction hasn't finished, but
that doesn't mean that no data blocks made it to disk, right? We won't
expose stale disk blocks, right, but there is still a mix between new and
old file data in this situation. I assume e2fsck will warn about this?

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

