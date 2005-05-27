Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVE0UvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVE0UvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVE0Uu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:50:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:8832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262589AbVE0Uuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:50:39 -0400
Date: Fri, 27 May 2005 13:51:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: ALSA official git repository
Message-Id: <20050527135124.0d98c33e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > 
> > Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> > proper comments again. Also, the author is not correct (should be taken
> > from the first Signed-off-by:).
> 
> Hmm.. That's not always true in general, since Sign-off does allow to sign
> off on other peoples patches (see the "(b)" clause in DCO), but maybe in
> the ALSA tree it is.

Yes, I'll occasionally do patches which were written by "A" as:

From: A
...
Signed-off-by: B

And that comes through email as:


...
From: <akpm@osdl.org>
...
From: A
...
Signed-off-by: B


which means that the algorithm for identifying the author is "the final
From:".

I guess the bug here is the use of From: to identify the primary author,
because transporting the patch via email adds ambiguity.

Maybe we should introduce "^Author:"?

