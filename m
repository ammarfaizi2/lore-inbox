Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUJIXER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUJIXER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUJIXEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:04:10 -0400
Received: from findaloan.ca ([66.11.177.6]:18352 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S267543AbUJIXEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:04:00 -0400
Date: Sat, 9 Oct 2004 18:59:32 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041009225932.GA10732@mark.mielke.cc>
Mail-Followup-To: Martijn Sipkema <martijn@entmoot.nl>,
	David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
References: <000801c4ae35$3520ac90$161b14ac@boromir> <MDEHLPKNGKAHNMBLJOLKEEAPOOAA.davids@webmaster.com> <20041009184922.GA8032@mark.mielke.cc> <001d01c4ae43$06f83c30$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c4ae43$06f83c30$161b14ac@boromir>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 10:00:35PM +0100, Martijn Sipkema wrote:
> [...]
> > Please - people who don't agree, just ensure that Linux is documented
> > to not implement select() on sockets without O_NONBLOCK properly.
> Actually, the behaviour isn't correct for sockets with O_NONBLOCK
> either, since EAGAIN may only be returned when recvmsg() would not
> block without O_NONBLOCK.

At least this one is acceptable, though, as most current applications
won't break, or be open to attack. I agree - it should also be documented
as improper, but with enough words to point out that it isn't a big deal.

I think you and I are on the same page.

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

