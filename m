Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbREBMI6>; Wed, 2 May 2001 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132850AbREBMIs>; Wed, 2 May 2001 08:08:48 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:61317 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132834AbREBMIl>; Wed, 2 May 2001 08:08:41 -0400
From: Christoph Rohland <cr@sap.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MM mailing list <linux-mm@kvack.org>
Subject: Re: [Patch] deadlock on write in tmpfs
In-Reply-To: <m3hez5ci6p.fsf@linux.local> <20010501173210.S26638@redhat.com>
Organisation: SAP LinuxLab
Date: 02 May 2001 14:00:53 +0200
In-Reply-To: <20010501173210.S26638@redhat.com>
Message-ID: <m3hez4arka.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 1 May 2001, Stephen C. Tweedie wrote:
> If the locking is for a completely different reason, then a
> different semaphore is quite appropriate.  In this case you're
> trying to lock the shm internal info structures, which is quite
> different from the sort of inode locking which the VFS tries to do
> itself, so the new semaphore appears quite clean --- and definitely
> needed.

It's not the addition to the inode semaphore I do care about, but the
addition to the spin lock which protects also the shmem internals. But
you are probably right: It only protects the onthefly pages between
page cache and swap cache.

Greetings
		Christoph


