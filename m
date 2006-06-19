Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWFSPwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWFSPwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWFSPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:52:47 -0400
Received: from mail.daysofwonder.com ([213.186.49.53]:23952 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S964780AbWFSPwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:52:46 -0400
Subject: Re: 2.6.17: slow (as hell) tcp inbound transfers
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org,
       Vincent Vanackere <vincent.vanackere@gmail.com>
In-Reply-To: <200606200115.02492.kernel@kolivas.org>
References: <1150725598.4985.27.camel@localhost.localdomain>
	 <65258a580606190717t2cc5b28eg10fb4d64fe5ec1f3@mail.gmail.com>
	 <1150729187.4985.41.camel@localhost.localdomain>
	 <200606200115.02492.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 17:52:43 +0200
Message-Id: <1150732363.4985.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 01:15 +1000, Con Kolivas wrote:
> On Tuesday 20 June 2006 00:59, Brice Figureau wrote:
> > On Mon, 2006-06-19 at 16:17 +0200, Vincent Vanackere wrote:
> > > On 6/19/06, Brice Figureau <brice+lklm@daysofwonder.com> wrote:
> > > > It seems that TCP inbound transfers (using either curl, or scp) are
> > > > really slow except when issued on our gigabit LAN.
> > >
> > > Could you try the following to see if it cures your problem ?
> > >
> > > echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
> >
> > Yes, that fixed it:
> > [snipped]
> > Did something has changed between 2.6.16 and 2.6.17 regarding TCP window
> > scaling ?
> >
> > I remember a discussion on lklm aroung 2.6.7 or so that finally ended as
> > a bug in a firewall that wasn't handling TCP window scaling gracefully.
> > That's certainly my case, I'll will have a look to that.
> 
> See:
> 
> http://kerneltrap.org/node/6723

Thanks for the pointer and sorry for the noise.
-- 
Brice Figureau

