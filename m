Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUF1Vtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUF1Vtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUF1Vtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:49:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:41105 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265229AbUF1Vts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:49:48 -0400
Date: Mon, 28 Jun 2004 23:49:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] signal handler defaulting fix ...
Message-ID: <20040628214942.GC29901@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com> <20040628144003.40c151ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040628144003.40c151ff.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 June 2004 14:40:03 -0700, Andrew Morton wrote:
> Davide Libenzi <davidel@xmailserver.org> wrote:
> >
> > 
> > Following up from the other thread (2.6.x signal handler bug) this bring 
> > 2.4 behaviour in 2.6.
> > 
> 
> Pity the poor person who tries to understand this change in a year's time. 
> Could we have a real changelog please?

It better be a good one.  I've hit a real problem that raised more
than a few eyebrows.  In short, if some program is stupid enough to
cause a segfault inside a segfault-handler, it doesn't have a reason
to survive.

Your patch will let the poor creature live an unhappy life.  No good.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
