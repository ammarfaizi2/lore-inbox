Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291613AbSBAJBD>; Fri, 1 Feb 2002 04:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291612AbSBAJAr>; Fri, 1 Feb 2002 04:00:47 -0500
Received: from sun.fadata.bg ([80.72.64.67]:11282 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291613AbSBAJAZ>;
	Fri, 1 Feb 2002 04:00:25 -0500
To: <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
Date: 01 Feb 2002 11:01:50 +0200
Message-ID: <87u1t1shhd.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> On 1 Feb 2002, Momchil Velikov wrote:
>> So, we can use a read-write spinlock instead ->i_shared_lock, ok ?

Ingo> using read-write locks does not solve the scalability problem: the problem
Ingo> is the bouncing of the spinlock cacheline from CPU to CPU.

Does cache line bounce (shared somewhere -> exclusive elsewhere) cost
more that a simple miss (present nowhere -> exclusive somewhere) ?

Regards,
-velco

