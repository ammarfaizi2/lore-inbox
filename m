Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273568AbRIVMLl>; Sat, 22 Sep 2001 08:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274895AbRIVMLb>; Sat, 22 Sep 2001 08:11:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23051 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273568AbRIVMLY>;
	Sat, 22 Sep 2001 08:11:24 -0400
Date: Sat, 22 Sep 2001 14:11:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922141145.A1969@suse.de>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com> <20010917000012.B12270@suse.de> <20010921114448.D1924@devserv.devel.redhat.com> <20010922130000.A632@suse.de> <20010922071839.A10727@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010922071839.A10727@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22i
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22 2001, Arjan van de Ven wrote:
> On Sat, Sep 22, 2001 at 01:00:00PM +0200, Jens Axboe wrote:
> > megaraid broke because can_dma_32 was enabled by mistake.
> 
> Nope; without that it was still bust.
> Megaraid broke (and 3ware most likely as well) because  it had broken code
> for the "only 1 scatter gather element" case....

Ah ok, that's actually a case I hadn't counted on being buggy in
drivers. Typical, drive code sucks :-)

jens
