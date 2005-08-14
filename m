Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVHNQWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVHNQWD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 12:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVHNQWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 12:22:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:59879 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932532AbVHNQWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 12:22:02 -0400
Date: Sun, 14 Aug 2005 18:22:00 +0200
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
Message-ID: <20050814162200.GU22901@wotan.suse.de>
References: <200508141214_MC3-1-A731-BBE9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508141214_MC3-1-A731-BBE9@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 12:12:52PM -0400, Chuck Ebbert wrote:
>   The first thing drivers/char/mem.c:read_kmem does is convert the
> loff_t it gets as the offset for reading into an unsigned int.  This
> patch makes the kmem driver's llseek operator do that up-front, so
> that fs/read_write.c:rw_verify_area doesn't return -EINVAL when
> we try to read from higher addresses.
> 
>   It's ugly but so is the existing code.  And it won't fix 64-bit
> archs AFAICT.  Tested on 2.6.11, patch offsets fixed up for 2.6.13-rc6.

I already have a full patch for this issue queued for 2.6.14.

-Andi
