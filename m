Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSLKIR4>; Wed, 11 Dec 2002 03:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSLKIR4>; Wed, 11 Dec 2002 03:17:56 -0500
Received: from crack.them.org ([65.125.64.184]:29605 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267065AbSLKIRz>;
	Wed, 11 Dec 2002 03:17:55 -0500
Date: Wed, 11 Dec 2002 03:26:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021211082622.GA27304@nevyn.them.org>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jim Houston <jim.houston@ccur.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
	"David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
	schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
References: <3DF06B15.1F6ECD5D@mvista.com> <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com> <20021209154142.GA22901@nevyn.them.org> <3DF673B9.4E273E83@mvista.com> <20021211071041.GA8988@nevyn.them.org> <3DF6F31F.DBB24F10@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF6F31F.DBB24F10@mvista.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 12:11:11AM -0800, george anzinger wrote:
> So, is this overkill?

Yes.  I'm also 99% certain it won't solve the problem.  Really, the
only way to get this right is to make sure all the state is out where
GDB will see it and protect it.  But it sounds like doing this on S/390
and ia64 is prohibitively complicated.

I'll think about it.  If we can't come up with anything better we may
want to just make this behave correctly on those architectures that can
do it.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
