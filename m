Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVH0DvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVH0DvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 23:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVH0DvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 23:51:07 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:23279 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1030295AbVH0DvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 23:51:05 -0400
Date: Fri, 26 Aug 2005 20:58:53 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alexey Dobriyan <adobriyan@gmail.com>, Paul Jackson <pj@sgi.com>,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050827035853.GG91880@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru> <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk> <20050825072731.GA876@mipter.zuzino.mipt.ru> <20050825190755.GV9322@parcelfarce.linux.theplanet.co.uk> <20050825221649.GA31305@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825221649.GA31305@twiddle.net>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 26 Aug 2005 20:58:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> Because I use "extern inline" in the proper way.  That is, I have both
> inline and out-of-line versions of some routines.

Is there any reason not to just make the out-of-line version explicit?
i.e.:

	/* in some .h file: */
	static /*(always!)*/inline int my_func(void)
	{
		return FOO;
	}
	extern int OOL_my_func(void);

	/* in some .c file: */
	int OOL_my_func(void)
	{
		return my_func();
	}

It's a little ugly but there really aren't that many cases of this, right?
Or is this just the principal of the thing? :-)

-Mitch
