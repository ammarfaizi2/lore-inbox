Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbSJEPZj>; Sat, 5 Oct 2002 11:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262375AbSJEPZj>; Sat, 5 Oct 2002 11:25:39 -0400
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:61941 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S262374AbSJEPZj>;
	Sat, 5 Oct 2002 11:25:39 -0400
Date: Sat, 5 Oct 2002 21:30:14 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] 2.5.40 de2104x: a lots of timer messages
Message-ID: <20021005213014.A320@natasha.zzz.zzz>
References: <20021004225051.B346@natasha.zzz.zzz> <3D9DF1EB.8040807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9DF1EB.8040807@pobox.com>; from jgarzik@pobox.com on Fri, Oct 04, 2002 at 03:54:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 03:54:19PM -0400, Jeff Garzik wrote:
> Denis Zaitsev wrote:
> > This patch fixes a lots of annoying timer messages for this ethernet
> > adapter.  Please, apply it.
> 
> 
> If the messages annoy you, disable that bit using ethtool.  It's not 
> necessary to hack the driver for this.
> 

It's hard to really call that a "hack"...
And do you want to say that you won't be annoyed, if each minute you
have on your console the message:

        eth0: 10baseT auto link ok, mode 7ffc2002 status 51c8

I.e. 1440 of the same messages per day...  So, will you?  Or another
approach: the only one of all the other drivers/net use
NETIF_MSG_TIMER included into xxx_DEF_MSG_ENABLE, and this one is
Tigon3 driver, which is, again, your.  And no one else.  And this
silence seems to be a some kind of a "normal" behaviour, doesn't it?
And no one of other drivers needs ethtool to be just silent...

Or, may be there are some reasons for such a verbosing, I just don't
know about?

And, important: of course, I had to send the patch to you.  I'm sorry,
for some reason I decided that the driver is unmaintained for the some
time.
