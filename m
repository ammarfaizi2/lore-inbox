Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbQL2KHk>; Fri, 29 Dec 2000 05:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbQL2KHa>; Fri, 29 Dec 2000 05:07:30 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3228 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130092AbQL2KHM>; Fri, 29 Dec 2000 05:07:12 -0500
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001228160005.B14479@metastasis.f00f.org>
	<Pine.LNX.4.10.10012281049140.12260-100000@penguin.transmeta.com>
	<20001229143200.A16930@metastasis.f00f.org>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20001229143200.A16930@metastasis.f00f.org>
Message-ID: <m3elyrr2pg.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 29 Dec 2000 10:39:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> I would prefer we leave ramfs alone as is -- it makes an excellent
> starting point for a new fs and is fairly simple to grok. If we are
> to add any more complexity here like the size limiting patches or the
> use of a backing store, I'd like to have this as a new filesystem,
> something like 'vmfs' or some such.

That's shm fs + read and write which should be easy to add.

> ramfs is small simple and elegant; for mere mortals like me it
> contains enough to help understand what is required of a filesystem
> without obscuring this fact. I'd hate to see that change.

yes. That's why I copied a lot of the ramfs code into mm/shmem.c

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
