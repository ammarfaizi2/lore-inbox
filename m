Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266084AbUGAQug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUGAQug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUGAQug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:50:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:49605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266084AbUGAQue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:50:34 -0400
Date: Thu, 1 Jul 2004 09:50:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <200407010702.i6172O38019744@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0407010948220.11212@ppc970.osdl.org>
References: <200407010702.i6172O38019744@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Roland McGrath wrote:
> > 
> > 	list_for_each_safe(..)
> 
> You know, I never really looked at the macros, but seeing "_safe" here made
> me think that exactly this is what it's safe from.  That was obviously a
> silly thing to think, since it's clearly just safe from removing the list
> element during the iteration.

Right. I'd love to say it's "always safe", but obviously that is not 
technically possible. I agree that the name is misleading, and it is more 
about "can_delete" than about being "safe".

Anyway, I applied your/Andrea's patch (I happened to read email backwards 
this morning, so I saw Andrea's first).

		Linus
