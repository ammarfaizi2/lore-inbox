Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbRFPMQ6>; Sat, 16 Jun 2001 08:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbRFPMQt>; Sat, 16 Jun 2001 08:16:49 -0400
Received: from pD951C9A8.dip.t-dialin.net ([217.81.201.168]:24192 "EHLO
	solo.franken.de") by vger.kernel.org with ESMTP id <S264618AbRFPMQd>;
	Sat, 16 Jun 2001 08:16:33 -0400
Date: Sat, 16 Jun 2001 14:11:40 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Faure <paul@engsoc.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.0.35 limits
Message-ID: <20010616141140.A1593@solo.franken.de>
In-Reply-To: <Pine.LNX.4.33.0106151702300.22155-100000@stout.engsoc.carleton.ca> <E15B17v-000790-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15B17v-000790-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 15, 2001 at 10:27:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 10:27:35PM +0100, Alan Cox wrote:
> > Just this morning, our firewall get a kernel panic after 500 days of
> > uptime.
> 
> Interesting very interesting in fact. There is a 497 day wrap on the kernel but
> it should do nothing more than send the uptime back to zero. Im not sure
> how the crash fits in to this but it could be significant that its about
> the wrap time

there is a division by zero possibilty in the 2.0.35 do_fast_gettimeoffset
(there is a division by jiffies, which is 0 for one tick). Our department
server got struck by this at the jiffies rollover some time ago.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
