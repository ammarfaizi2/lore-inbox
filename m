Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272264AbRIVVgk>; Sat, 22 Sep 2001 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272270AbRIVVga>; Sat, 22 Sep 2001 17:36:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26240 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272264AbRIVVgO>;
	Sat, 22 Sep 2001 17:36:14 -0400
Date: Sat, 22 Sep 2001 14:36:24 -0700 (PDT)
Message-Id: <20010922.143624.59468806.davem@redhat.com>
To: davidel@xmailserver.org
Cc: ralf@conectiva.com.br, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, andrea@suse.de, manfred@colorfullife.com,
        riel@conectiva.com.br
Subject: Re: Purpose of the mm/slab.c changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <XFMail.20010922140302.davidel@xmailserver.org>
In-Reply-To: <20010922142847.A20641@dea.linux-mips.net>
	<XFMail.20010922140302.davidel@xmailserver.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Davide Libenzi <davidel@xmailserver.org>
   Date: Sat, 22 Sep 2001 14:03:02 -0700 (PDT)

   Besides this, i don't get how a LIFO could help you.

Actually, there is a school of thought which says that if you make the
time between the free and re-alloc of a piece of memory as long as
possible you increase the likelyhood that any dirty cache lines of
that memory can be sent back to memory "quietly" during natural L2
cache line replacement.

I don't necessarily subscribe to these ideas, but I do see the
potential benefits.  For one thing, it does have the potential to lead
to more repeatable timings, at least in theory.

Later,
David S. Miller
davem@redhat.com
