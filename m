Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQL0QGE>; Wed, 27 Dec 2000 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQL0QFz>; Wed, 27 Dec 2000 11:05:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:42418 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129610AbQL0QFj>; Wed, 27 Dec 2000 11:05:39 -0500
To: Dave Gilbert <gilbertd@treblig.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <Pine.LNX.4.10.10012271156200.2753-100000@tardis.home.dave>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10012271156200.2753-100000@tardis.home.dave>
Message-ID: <m3r92tancw.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 27 Dec 2000 16:37:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Gilbert <gilbertd@treblig.org> writes:

>   I think I've come to the conclusion that Xine does not in the case
> I've found, rely on this - it is a separate bug related to Xv
> telling xine that it needs 0 bytes.

Yes, but this bug did not show on 2.2. It simply failed in shmget.

Probably it makes more sense to fail on creation of zero byte segments
and getting existing ones with zero length being legal... (The latter
is needed). That's what the patch does.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
