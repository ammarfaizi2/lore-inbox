Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273586AbRIUPot>; Fri, 21 Sep 2001 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273584AbRIUPoj>; Fri, 21 Sep 2001 11:44:39 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12093 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273580AbRIUPoY>; Fri, 21 Sep 2001 11:44:24 -0400
Date: Fri, 21 Sep 2001 11:44:48 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, arjanv@redhat.com,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010921114448.D1924@devserv.devel.redhat.com>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com> <20010917000012.B12270@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010917000012.B12270@suse.de>; from axboe@suse.de on Mon, Sep 17, 2001 at 12:00:12AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 12:00:12AM +0200, Jens Axboe wrote:
> On Sun, Sep 16 2001, Linus Torvalds wrote:
> > 
> > On Sun, 16 Sep 2001, Jens Axboe wrote:
> > >
> > > It's against 2.4.10-pre9 and can be found right here:
> > >
> > > *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10-pre9/block-highmem-all-14
> > 
> > Jens, what's your feeling about the stability of these things, especially
> > wrt weird drivers?
> 
> One of the very first decisions I made wrt this patch was to make sure
> that weird/old drivers could keep on working exactly the way they do now
> and never have to worry about highmem stuff. 

unfortionatly, so far both megaraid and the 3ware driver broke. Megaraid is
easily fixable, but still. It shows that this patch is not without risk...



