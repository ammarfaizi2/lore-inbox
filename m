Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUJHDxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUJHDxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUJHDxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:53:03 -0400
Received: from findaloan.ca ([66.11.177.6]:8679 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S267483AbUJHDxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 23:53:00 -0400
Date: Thu, 7 Oct 2004 23:48:48 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@davemloft.net>
Cc: cfriesen@nortelnetworks.com, martijn@entmoot.nl, hzhong@cisco.com,
       jst1@email.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041008034848.GA1130@mark.mielke.cc>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	cfriesen@nortelnetworks.com, martijn@entmoot.nl, hzhong@cisco.com,
	jst1@email.com, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk, davem@redhat.com
References: <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <4165C20D.8020808@nortelnetworks.com> <20041007152634.5374a774.davem@davemloft.net> <4165C58A.9030803@nortelnetworks.com> <20041007154204.44e71da6.davem@davemloft.net> <20041008025148.GA724@mark.mielke.cc> <20041007203943.24560c33.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007203943.24560c33.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:39:43PM -0700, David S. Miller wrote:
> On Thu, 7 Oct 2004 22:51:48 -0400
> Mark Mielke <mark@mark.mielke.cc> wrote:
> > Your position, I believe has been that the use of select() on a blocking
> > file descriptor is invalid.
> Incorrect.
> My position is that expecting a blocking file descriptor not to
> block is invalid.

Extrapolated, this would be - use of select() on a blocking file descriptor
is invalid.

Otherwise, what would be the point of using select() only to accidentally
block a small percentage of the time that one couldn't predict?

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

