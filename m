Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279910AbRJ3KoX>; Tue, 30 Oct 2001 05:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279911AbRJ3KoO>; Tue, 30 Oct 2001 05:44:14 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:58952 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S279910AbRJ3KoK>; Tue, 30 Oct 2001 05:44:10 -0500
Date: Tue, 30 Oct 2001 05:44:32 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Christoph Hellwig <hch@caldera.de>,
        Mike Jagdis <jaggy@purplet.demon.co.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [PATCH] syscall exports - against 2.4.14-pre3
Message-ID: <20011030054432.B28368@devserv.devel.redhat.com>
In-Reply-To: <20011029173711.B24272@caldera.de> <3BDE7D22.8000006@purplet.demon.co.uk> <20011030113731.A14808@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030113731.A14808@caldera.de>; from hch@caldera.de on Tue, Oct 30, 2001 at 11:37:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 11:37:31AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 30, 2001 at 10:12:50AM +0000, Mike Jagdis wrote:
> > > once again the syscall export patch - back to EXPORT_SYMBOL

> "Because we did it all the time it's right".
> 
> Of course it worked - that doesn't mean it's a good idea.
> Arjan might want to comment on how gcc 2.96+ liked the old concept..

gcc 2.96 and 3.0 _rightfully_ object to calling a function pointer with a
different number of arguments than the function pointer prototype is. Even
if gcc didn't object to it, I consider it butt-ugly and you also just lost
any and all type checking the compiler can help you with. During the change
to calling the real functions instead of the basicaly untyped function
pointers, quite a few ibcs bugs were fixed just because the arguments were
wrong. I'm with Christoph on this 100%.

Greetings,
   Arjan van de Ven
