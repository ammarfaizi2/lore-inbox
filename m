Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTFGQWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGQWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:22:46 -0400
Received: from holomorphy.com ([66.224.33.161]:15303 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262562AbTFGQWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:22:45 -0400
Date: Sat, 7 Jun 2003 09:35:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ren? Scharfe <l.s.r@web.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] hugetlbfs: fix error reporting in case of invalid mount options
Message-ID: <20030607163521.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ren? Scharfe <l.s.r@web.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030607145532.2bc66f38.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607145532.2bc66f38.l.s.r@web.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 02:55:32PM +0200, Ren? Scharfe wrote:
> there is not much point in trying to print the mount options after
> hugetlbfs_parse_options() went over them.
> Since it employs strsep(), it cuts the option string into pieces by
> replacing all commas with NUL characters. A following printk() will
> always show the first option, only, which could be confusing.
> The patch below changes hugetlbfs to not try to echo the string of
> mount options in case of an error at all. It wouldn't tell us anything
> we didn't know before, anyway.

Let's nuke it entirely. All other fs's barf without printk()'ing at all
and kick -EINVAL back to the caller.


-- wli
