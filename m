Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135343AbRANVkY>; Sun, 14 Jan 2001 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135439AbRANVkO>; Sun, 14 Jan 2001 16:40:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:8442 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135343AbRANVkA>; Sun, 14 Jan 2001 16:40:00 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SetPageDirty in shmem_nopage
In-Reply-To: <Pine.LNX.4.10.10101141116550.4086-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10101141116550.4086-100000@penguin.transmeta.com>
Message-ID: <m3ae8tg6kr.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Jan 2001 22:44:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 14 Jan 2001, Christoph Rohland wrote:
> Why do you increment the use counter at all in nopage?

First to be able to limit the overall number of pages used by the
filesystem and second to have the right value for the number of blocks
in [f]stat.

Show me a way to get the overall number of vm pages in the fs and I
drop it in a minute.

> It looks like this code is all historical baggage from when the
> shm code didn't use the VM page cache?

No, it was introduced with the changes to use the page cache.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
