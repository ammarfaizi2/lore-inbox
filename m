Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUIKSJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUIKSJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIKSJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:09:35 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:59165 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268248AbUIKSJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:09:33 -0400
Message-ID: <9e4733910409111109c6d8419@mail.gmail.com>
Date: Sat, 11 Sep 2004 14:09:32 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: radeon-pre-2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409111405140.15792@node2.an-vo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com>
	 <1094913414.21157.65.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com>
	 <1094915671.21290.77.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com>
	 <1094919630.21082.116.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409111346170.15792@node2.an-vo.com>
	 <9e473391040911105942f52db6@mail.gmail.com>
	 <Pine.LNX.4.61.0409111405140.15792@node2.an-vo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 14:05:54 -0400 (EDT), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> > All register writes would occur in the driver. There is nothing
> > stopping the code that computes those register values from running in
> > user space.
> >
> > A example mode setting IO would take:
> >  display buffer offset
> >  width, height, stride, etc - for fbcon to use
> >  register values to set the mode
> >
> > Mode setting needs to be serialized. It may be better to do the
> > serialization before the hotplug event, in that case the mode setting
> > IOCTL would be implicitly serialized and not need a separate lock.
> 
> Just to clear up things - do you plan to retain the knowledge of last mode
> set in the DRM driver ?

Yes, you have to do that for fbcon and suspend/restore to work.

-- 
Jon Smirl
jonsmirl@gmail.com
