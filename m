Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbREUKnn>; Mon, 21 May 2001 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbREUKnd>; Mon, 21 May 2001 06:43:33 -0400
Received: from ns.suse.de ([213.95.15.193]:23566 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262459AbREUKnR>;
	Mon, 21 May 2001 06:43:17 -0400
Date: Mon, 21 May 2001 12:42:25 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521124225.A3417@gruyere.muc.suse.de>
In-Reply-To: <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de> <15112.59192.613218.796909@pizda.ninka.net> <20010521122753.A2507@gruyere.muc.suse.de> <15112.61258.251051.960811@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.61258.251051.960811@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:34:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:34:50AM -0700, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > [BTW, the 2.4.4 netstack does not seem to make any attempt to handle the
>  > pagecache > 4GB case on IA32 for sendfile, as the pci_* functions are dummies 
>  > here.  It probably needs bounce buffers there for this case]
> 
> egrep illegal_highdma net/core/dev.c

There is just no portable way for the driver to figure out if it should
set this flag or not. e.g. acenic.c gets it wrong: it is unconditionally
set even on IA32. Currently it requires an architecture ifdef to set properly.

-Andi
