Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTEWARs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTEWARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:17:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11534 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263493AbTEWARn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:17:43 -0400
Date: Thu, 22 May 2003 17:30:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [patch?] truncate and timestamps
In-Reply-To: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 May 2003 Andries.Brouwer@cwi.nl wrote:
> 
> On the other hand, my question was really a different one:
> do we want to follow POSIX, also in the silly requirement
> that truncate only sets mtime when the size changes, while
> O_TRUNC and ftruncate always set mtime.

Does POSIX really say that? What a crock. If so, we should probably add 
the ATTR_xxx mask as an argument to do_truncate() itself, and then make 
sure that may_open() sets the ATTR_MTIME bit.

		Linus

