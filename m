Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280937AbRKTVmq>; Tue, 20 Nov 2001 16:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280952AbRKTVmh>; Tue, 20 Nov 2001 16:42:37 -0500
Received: from [194.46.8.33] ([194.46.8.33]:62482 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S280937AbRKTVmZ>;
	Tue, 20 Nov 2001 16:42:25 -0500
Date: Tue, 20 Nov 2001 21:47:05 +0000
From: Dale Amon <amon@vnl.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
Message-ID: <20011120214705.D22590@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011120190316.H19738@vnl.com> <2048.1006291657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2048.1006291657@redhat.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 09:27:37PM +0000, David Woodhouse wrote:
> Why must the motherboard be set to eth0? Why not just configure it as it
> gets detected?

There are a couple reasons. One that is specific to this
particular case is that the VeryExpensiveProprietaryPackage
someone bought checks the eth0 MAC address to be sure you
haven't moved it. It would not really be smart to license
it against a removable, swappable PCI card.

In general: I have more than once gotten bitten late
in the night modifying kernels where I switched something
from modular to non-modular and lost communication with
the machine when it came back up. At 4am these things *do*
happen.

I'd really not mind the ability to say MAC addresss X is
by definition ethY. That would work for me because the only
way you get screwed is if you change the NIC. And if you
are swapping out hardware, you are usually physically present
to sort things out if your network gets effed.

> If you really care about the names, there's an ioctl you can use to change
> them. You can call them 'fred' and 'sheila' if you so desire.

The iproute2 commands another fellow mentioned look
like they will do the job nicely for my particular
immediate problem.

In the more general case though, I can see a need to
explicitely force or override assignments in special 
circumstances.

--
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

