Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132221AbRASRpz>; Fri, 19 Jan 2001 12:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133086AbRASRpq>; Fri, 19 Jan 2001 12:45:46 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:37086 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132221AbRASRpg>; Fri, 19 Jan 2001 12:45:36 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: set_page_dirty/page_launder deadlock
In-Reply-To: <Pine.LNX.4.10.10101141054530.4086-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
Date: 19 Jan 2001 18:44:44 +0100
Message-ID: <qww4ryv308j.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, 14 Jan 2001, Linus Torvalds wrote:
> Well, as the new shm code doesn't return 1 any more, the whole
> locked page handling should just be deleted. ramfs always just
> re-marked the page dirty in its own "writepage()" function, so it
> was only shmfs that ever returned this special case, and because of
> other issues it already got excised by Christoph..

No, that's not completely right. There may be rare cases like out of
swap that shmem_write does return 1. But couldn't it simply set the
page dirty like ramfs_writepage?

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
