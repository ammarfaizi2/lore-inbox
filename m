Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVBXAMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVBXAMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVBXAJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:09:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:1705 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261709AbVBXAAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:00:53 -0500
Date: Thu, 24 Feb 2005 00:00:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050224000037.GC11473@mail.shareable.org>
References: <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org> <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org> <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org> <20050223184946.GA11473@mail.shareable.org> <20050223191254.GA5608@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223191254.GA5608@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> How's this? I went with get_val_no_fault(), since it isn't really a
> get_user.*() any more (ptr being passed in), and no_paging is a little
> misleading (not all faults are due to paging).

How ironic: I deliberately didn't choose "no_fault" because that
function *does* take page faults.  It only disables paging operations! :)

-- Jamie
