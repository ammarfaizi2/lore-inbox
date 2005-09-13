Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVIMV4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVIMV4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVIMV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:56:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932501AbVIMV4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:56:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Sripathi Kodi <sripathik@in.ibm.com>
X-Fcc: ~/Mail/linus
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: Sripathi Kodi's message of  Tuesday, 13 September 2005 16:30:43 -0500 <43274503.7090303@in.ibm.com>
Emacs: a learning curve that you can use as a plumb line.
Message-Id: <20050913215624.ACD90180A1A@magilla.sf.frob.com>
Date: Tue, 13 Sep 2005 14:56:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might suffice to move __exit_fs to the top of release_task.  (Perhaps
that requires moving exit_namespace after it, I don't know if it matters.)
Then a zombie group leader won't release and clear ->fs before the whole
group dies.


Thanks,
Roland
