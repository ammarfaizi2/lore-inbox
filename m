Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCSDra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCSDra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 22:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWCSDra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 22:47:30 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:42692 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750924AbWCSDr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 22:47:29 -0500
Date: Sun, 19 Mar 2006 11:47:51 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Message-ID: <20060319034750.GA8732@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
References: <20060319023413.305977000@localhost.localdomain> <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 10:10:43PM -0500, Jon Smirl wrote:
> This is probably a readahead problem. The lighttpd people that are
> encountering this problem are not regular lkml readers.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5949

[QUOTE]
        My general conclusion is that since they were able to write a user
        space implementation that avoids the problem something must be broken
        in the kernel readahead logic for sendfile().

Maybe the user space solution does the trick by using a larger window size?

IMHO, the stock read-ahead is not designed with extremely high concurrency in
mind. However, 100 streams should not be a problem at all.

Wu
