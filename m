Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWDGSCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWDGSCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWDGSCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:02:45 -0400
Received: from nevyn.them.org ([66.93.172.17]:52958 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S964836AbWDGSCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:02:44 -0400
Date: Fri, 7 Apr 2006 14:02:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
Message-ID: <20060407180243.GA27828@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060406.140357.14088592.davem@davemloft.net> <20060406221519.GA5453@nevyn.them.org> <20060406.153518.60508780.davem@davemloft.net> <20060406.221807.114721185.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406.221807.114721185.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 10:18:07PM -0700, David S. Miller wrote:
> How about something like the following patch?  If it's executable
> and not written to, skip it.  This would skip the main executable
> image and all text segments of the shared libraries mapped in.

Will this dump text segments that have been COW'd for the purposes of
inserting a breakpoint?

It's just a question of goals, I guess.  We could dump code, but it's
rarely useful, so historically we didn't.  Similarly, we could dump
mapped data from shared memory, but it can be huge and is rarely
useful, so generally we don't.

-- 
Daniel Jacobowitz
CodeSourcery
