Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWEaVy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWEaVy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWEaVy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:54:26 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:549 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965187AbWEaVyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:54:25 -0400
X-IronPort-AV: i="4.05,195,1146466800"; 
   d="scan'208"; a="286453267:sNHT34696668"
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Steve Wise <swise@opengridcomputing.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
X-Message-Flag: Warning: May contain useful information
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182652.3308.1244.stgit@stevo-desktop>
	<20060531114059.704ef1f1@localhost.localdomain>
	<ada3beqyp39.fsf@cisco.com> <1149109080.7469.15.camel@stevo-desktop>
	<20060531140100.36024296@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 31 May 2006 14:54:22 -0700
In-Reply-To: <20060531140100.36024296@localhost.localdomain> (Stephen Hemminger's message of "Wed, 31 May 2006 14:01:00 -0700")
Message-ID: <adaverlx3ld.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 21:54:24.0415 (UTC) FILETIME=[C7BA7AF0:01C684FC]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a silly thing to argue about, but...

 > The preferred form for passing a size of a struct is the following:
 > 
 > 	p = kmalloc(sizeof(*p), ...);
 > 
 > The alternative form where struct name is spelled out hurts readability and
 > introduces an opportunity for a bug when the pointer variable type is changed
 > but the corresponding sizeof that is passed to a memory allocator is not.

I would argue that this is talking about sizeof(*p) vs. sizeof (struct foo)
rather than sizeof(*p) vs. sizeof *p.

You wouldn't write:

	return(*p);

but rather

	return *p;

And sizeof is an operator not a function, so I think the same usage
would apply.

With that said the prevalent kernel usage does seem to be sizeof(*foo)
(by about 10 to 1).  But I can't help feeling it looks silly.

 - R.
