Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265683AbUEZNjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUEZNjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265687AbUEZNjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:39:46 -0400
Received: from holomorphy.com ([207.189.100.168]:38272 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265683AbUEZNiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:38:55 -0400
Date: Wed, 26 May 2004 06:38:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Satoshi Oshima <oshima@sdl.hitachi.co.jp>
Cc: orders@nodivisions.com, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526133844.GA2764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Satoshi Oshima <oshima@sdl.hitachi.co.jp>, orders@nodivisions.com,
	linux-kernel@vger.kernel.org
References: <40B43B5F.8070208@nodivisions.com> <JI20040526220006.47968296@sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JI20040526220006.47968296@sdl.hitachi.co.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 10:00:06PM +0900, Satoshi Oshima wrote:
> I really agree. And I think swappoff is not enough. Some of my
> customers have over 4GB of memory. RDMS, Java Virtual Machine or Grid
> system (like Globus tool kit) run on the servers. Those kinds of
> application make a lot of threads and they have huge amount of shared
> memory. And those shared memory is sometimes mlocked. I think, in
> those systems, memory aging itself is useless or obstructive in worst
> case. Because mlocked pages which can't be swapped off are on the LRU
> list. In such case, aging-off (relevant to process) is effective, I
> think. Of course, I agree that swap-off or aging-off is NEVER always
> useful. On the contrary, these functions may be required by very
> small number of user. But it is very important that we can choose 
> how we use the OS.

Could you try CONFIG_SWAP=n to see if that makes a difference?
More aggressive non-paging methods could be devised if not, e.g.
CONFIG_MMU=n support of various kinds for hardware supporting paging
and virtual memory (this is a suggestion, not an offer to implement).


-- wli
