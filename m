Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTL0A7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbTL0A7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:59:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:60837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265293AbTL0A7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:59:24 -0500
Date: Fri, 26 Dec 2003 16:59:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312261654310.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>  <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
  <1072482941.15458.90.camel@gaston>  <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
 <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Linus Torvalds wrote:
> 
> And it's not "read-only" - it's the "A" bit, not the "W" bit you should be 
> clearing in "ptep_test_and_clear_young()".

Oh, I see, I misparsed your comment.. you were talking about changing
"ptep_test_and_clear_dirty()"  too..

That's certainly possible.

		Linus
