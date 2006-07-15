Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWGOVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWGOVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWGOVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 17:41:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161066AbWGOVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 17:41:15 -0400
Date: Sat, 15 Jul 2006 14:40:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <w@1wt.eu>
cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org
Subject: Re: Linux 2.6.16.26
In-Reply-To: <20060715201810.GI2037@1wt.eu>
Message-ID: <Pine.LNX.4.64.0607151439020.5623@g5.osdl.org>
References: <20060715200856.GA15036@kroah.com> <20060715201026.GC15036@kroah.com>
 <20060715201810.GI2037@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Jul 2006, Willy Tarreau wrote:
> 
> You would need to git-reset then git-commit

Actually, these days we suggest doing

	git commit --amend

instead to change the top commit if you mis-type something or find a 
problem.

But, as you point out:

>					 but it's a little bit dirty
> and my annoy the users who will have already fetched your tree.

Indeed. Something that has already been exported should _not_ be amended, 
because it generates a whole new commit, and people who have already 
gotten the old one would be unhappy.

		Linus
