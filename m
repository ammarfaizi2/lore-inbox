Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274888AbRIVLSh>; Sat, 22 Sep 2001 07:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274893AbRIVLS2>; Sat, 22 Sep 2001 07:18:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:25490 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274888AbRIVLSP>; Sat, 22 Sep 2001 07:18:15 -0400
Date: Sat, 22 Sep 2001 07:18:39 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922071839.A10727@devserv.devel.redhat.com>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com> <20010917000012.B12270@suse.de> <20010921114448.D1924@devserv.devel.redhat.com> <20010922130000.A632@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010922130000.A632@suse.de>; from axboe@suse.de on Sat, Sep 22, 2001 at 01:00:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 01:00:00PM +0200, Jens Axboe wrote:
> megaraid broke because can_dma_32 was enabled by mistake.

Nope; without that it was still bust.
Megaraid broke (and 3ware most likely as well) because  it had broken code
for the "only 1 scatter gather element" case....
