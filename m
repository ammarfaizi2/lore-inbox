Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWAMQSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWAMQSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWAMQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:18:50 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:54770 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965032AbWAMQSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:18:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YWiXL57bL9BZZn8Gp0xUa9IiewTBsvMhiTwGePyEwvt4rRp2U+CsVmEgaFiX1JHQAd5PmadExyobQ27L0Z/lPv6PhYHDt5EpfyjkUp6f+mW9oINogaFnE54h+ZYWccACMCZGz/zbWX7T3ClVLzu33xKXDDQNjJ8jgsplWUjbtOQ=
Date: Fri, 13 Jan 2006 19:36:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Evgeniy <dushistov@mail.ru>
Subject: Re: Oops in ufs_fill_super at mount time
Message-ID: <20060113163601.GA13738@mipter.zuzino.mipt.ru>
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org> <20060113102136.GA7868@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 07:45:12AM -0800, Linus Torvalds wrote:
> On Fri, 13 Jan 2006, Alexey Dobriyan wrote:
>
> > On Thu, Jan 12, 2006 at 05:14:25PM -0800, Linus Torvalds wrote:
> > >
> > > This is a free'd page fault, so it's due to DEBUG_PAGEALLOC rather than a
> > > wild pointer.
> >
> > That's true. Turning it off makes mounting reliable again.
> >
> > > Is that something new for you? Maybe the bug is older, but you've enabled
> > > PAGEALLOC only recently?
> >
> > Yup. In response to hangs re disk activity.
>
> Ok, That explains why it started happening for you only _now_, but not why
> it happens in the first place.
>
> Can you test if the patch that Evgeniy sent out fixes it for you even with
> PAGEALLOC debugging enabled?

It does the trick! And you saved me from going before 2.6.0. ;-)

