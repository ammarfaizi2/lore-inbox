Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUJQALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUJQALq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUJQALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:11:46 -0400
Received: from findaloan.ca ([66.11.177.6]:10391 "EHLO vhosts.findaloan.ca")
	by vger.kernel.org with ESMTP id S268964AbUJQALo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:11:44 -0400
Date: Sat, 16 Oct 2004 20:06:26 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       David Schwartz <davids@webmaster.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017000626.GA27055@mark.mielke.cc>
Mail-Followup-To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	David Schwartz <davids@webmaster.com>
References: <20041016043540.GA17514@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com> <20041016062512.GA17971@mark.mielke.cc> <89DD4021-1FBC-11D9-942F-000A9567DDDE@e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89DD4021-1FBC-11D9-942F-000A9567DDDE@e18.physik.tu-muenchen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:44:21PM +0200, Roland Kuhn wrote:
> >You are talking about the make believe case that only exists due to
> >the *current* implementation of Linux UDP packet reading. It doesn't
> >have to exist. It exists only behaviour nobody saw fit to implement it
> >with semantics that were reliable, because the implentors didn't 
> >foresee
> >blocking file descriptors being used. It's an implementation oversight.
> Well, I haven't read the source to see what would be necessary to 
> create this behaviour, but David was talking about the situation where 
> the UDP packet is dropped because of memory pressure. This event cannot 
> possibly be foretold by select()...

I don't think he is, but if he is:

I'm not sure that either is reasonable behaviour. The socket buffers
don't increase or decrease at run time, do they? If they do shrink at
run time, this is news to me...

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

