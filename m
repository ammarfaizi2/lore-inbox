Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUIISZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUIISZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUIISYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:24:12 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:47011 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266526AbUIISJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:09:15 -0400
Date: Thu, 9 Sep 2004 11:09:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jakob Oestergaard <jakob@unthought.net>, Nathan Scott <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040909180903.GA8119@taniwha.stupidest.org>
References: <20040908123524.GZ390@unthought.net> <20040909074046.A3958243@wobbly.melbourne.sgi.com> <20040908232210.GL390@unthought.net> <20040909094255.F3951028@wobbly.melbourne.sgi.com> <20040909121100.GN390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909121100.GN390@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 02:11:00PM +0200, Jakob Oestergaard wrote:

> A google for 'debug.c:106' turns out some 120 results - it seems that no
> special magic is needed, other than a few boxes to set up the test
> scenario.

linux/fs/xfs/support/debuc.c:

    84	void
    85	cmn_err(register int level, char *fmt, ...)
    86	{
[...]
   105		if (level == CE_PANIC)
   106			BUG();
   107	}


Using cmn_err with CE_PANIC will show up as this, so it's likely your
google search is showing multiple different bugs, many of which have
been fixed.  You need to check the stack traces to see if they are the
same.


  --cw
