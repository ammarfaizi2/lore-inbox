Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUD2TWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUD2TWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUD2TWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:22:19 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:16828 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S264928AbUD2TWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:22:18 -0400
Date: Thu, 29 Apr 2004 12:22:09 -0700
From: Tim Hockin <thockin@sun.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG: might_sleep in /proc/swaps code
Message-ID: <20040429192209.GF1483@sun.com>
Reply-To: thockin@sun.com
References: <20040428232457.GB1483@sun.com> <20040429005333.GE17014@parcelfarce.linux.theplanet.co.uk> <20040429020309.GF17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429020309.GF17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 03:03:09AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> OK, here comes.  New semaphore protecting insertions/removals in the
> set of swap components + switch of ->start()/->stop() to the same
> semaphore [fixes deadlocks] + trivial cleanup of ->next().
> 
> See if it works for you...

Well, it stops bitching about might_sleep(), so it solves the obvious
problems.  I'm not in a position to comment about the other complexities of
swapfile.c, so I'll take it on faith that you got it right. :)

Thanks
Tim
