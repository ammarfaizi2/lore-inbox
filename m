Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSCRRd6>; Mon, 18 Mar 2002 12:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCRRdt>; Mon, 18 Mar 2002 12:33:49 -0500
Received: from mark.mielke.cc ([216.209.85.42]:57868 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S290423AbSCRRdi>;
	Mon, 18 Mar 2002 12:33:38 -0500
Date: Mon, 18 Mar 2002 12:29:17 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Jan Hudec <bulb@ucw.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020318122917.A27252@mark.mielke.cc>
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk> <a73ujs$5mc$1@cesium.transmeta.com> <20020318085811.GA21981@artax.karlin.mff.cuni.cz> <3C95BC82.2070003@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 05:08:02AM -0500, Jeff Garzik wrote:
> Jan Hudec wrote:
> >Then posix_fadvise interface can be implemented in libc using fcntl.
> It is far better for future-proofing the interface IMO if fadvise is 
> implementing directly.  Hints are less important than open O_xxx flags 
> or F_xxx flags, because an implementation can safely ignore 100% of the 
> fadvise hints, if it so chooses.  One cannot say the same thing for 
> open/fcntl flags.

There is nothing to say that fadvise(...) shouldn't call fcntl(F_ADVISE, ...).

If it fits in with open(), then it might just fit in with F_GETFL /
F_SETFL as well.

I prefer generalization, especially for non-critical functions that should
not be called 1,000,000 a second, such as fadvise().

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

