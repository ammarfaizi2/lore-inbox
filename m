Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTHBOnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTHBOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 10:43:19 -0400
Received: from waste.org ([209.173.204.2]:50881 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264030AbTHBOnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 10:43:19 -0400
Date: Sat, 2 Aug 2003 09:43:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-ID: <20030802144310.GH22824@waste.org>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org> <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 08:35:22AM -0400, Zwane Mwaikambo wrote:
> On Sat, 2 Aug 2003, Andrew Morton wrote:
> > Cannot perform userspace access while holding a lock - a pagefault could
> > occur, perform IO, schedule away and the same CPU tries to take the same
> > lock via a different process.
> 
> Perhaps might_sleep() in *_user, copy_* etc is in order?

Wouldn't have caught this case - this interface hasn't actually been
used/useful for many years as it only gives access to one of the
pools and has never been atomic either.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
