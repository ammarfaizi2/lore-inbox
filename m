Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSAaVOC>; Thu, 31 Jan 2002 16:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291317AbSAaVNw>; Thu, 31 Jan 2002 16:13:52 -0500
Received: from [217.9.226.246] ([217.9.226.246]:47488 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S291314AbSAaVNk>; Thu, 31 Jan 2002 16:13:40 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201311047200.1682-100000@penguin.transmeta.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0201311047200.1682-100000@penguin.transmeta.com>
Date: 31 Jan 2002 23:12:53 +0200
Message-ID: <87y9ierzqi.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

Linus> On Thu, 31 Jan 2002, Rik van Riel wrote:
>> 
>> It's still a question whether we'll want to use 128 as
>> the branch factor or another number ... but I'm sure
>> somebody will figure that out (and it can be changed
>> later, it's just one define).

Linus> Actually, I think the big question is whether somebody is willing to clean
Linus> up and fix the "move_from_swap_cache()" issue with block_flushpage.

Ah, almost forgot it. The patch removes ``next_hash'' and
``pprev_hash'' from ``struct page'', which breaks ARM and sparc64.

Regards,
-velco

