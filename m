Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274822AbRIVLAW>; Sat, 22 Sep 2001 07:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274888AbRIVLAM>; Sat, 22 Sep 2001 07:00:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S274822AbRIVK7z>;
	Sat, 22 Sep 2001 06:59:55 -0400
Date: Sat, 22 Sep 2001 13:00:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922130000.A632@suse.de>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com> <20010917000012.B12270@suse.de> <20010921114448.D1924@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921114448.D1924@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22i
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21 2001, Arjan van de Ven wrote:
> On Mon, Sep 17, 2001 at 12:00:12AM +0200, Jens Axboe wrote:
> > On Sun, Sep 16 2001, Linus Torvalds wrote:
> > > 
> > > On Sun, 16 Sep 2001, Jens Axboe wrote:
> > > >
> > > > It's against 2.4.10-pre9 and can be found right here:
> > > >
> > > > *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10-pre9/block-highmem-all-14
> > > 
> > > Jens, what's your feeling about the stability of these things, especially
> > > wrt weird drivers?
> > 
> > One of the very first decisions I made wrt this patch was to make sure
> > that weird/old drivers could keep on working exactly the way they do now
> > and never have to worry about highmem stuff. 
> 
> unfortionatly, so far both megaraid and the 3ware driver broke. Megaraid is
> easily fixable, but still. It shows that this patch is not without risk...

megaraid broke because can_dma_32 was enabled by mistake.

jens
