Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRADQ7K>; Thu, 4 Jan 2001 11:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADQ67>; Thu, 4 Jan 2001 11:58:59 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:31369 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129325AbRADQ6m>; Thu, 4 Jan 2001 11:58:42 -0500
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <774720000.978622231@tiny>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <774720000.978622231@tiny>
Message-ID: <m3snmzjlp6.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Jan 2001 18:01:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> Yes, right now the shmem writepage calls are the only ones returning one at
> all.  But, the question of how to properly fsync/msync these kinds of pages
> still stands.  Returning from an fsync before writing them isn't correct.

Yes, and [fm]sync should not do anything on shmem pages. There is
nothing to sync. So everything is fine.

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
