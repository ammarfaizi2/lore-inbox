Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADWEZ>; Thu, 4 Jan 2001 17:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRADWEQ>; Thu, 4 Jan 2001 17:04:16 -0500
Received: from jalon.able.es ([212.97.163.2]:22781 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129267AbRADWEB>;
	Thu, 4 Jan 2001 17:04:01 -0500
Date: Thu, 4 Jan 2001 23:03:48 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: So, what about kwhich on RH6.2?
Message-ID: <20010104230348.E1148@werewolf.able.es>
In-Reply-To: <20010104091241.B18973@gruyere.muc.suse.de> <E14EBZw-0005oG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14EBZw-0005oG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 04, 2001 at 15:41:17 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.04 Alan Cox wrote:
> > On Thu, Jan 04, 2001 at 07:13:58PM +1100, Andrew Morton wrote:
> > > Silly question:
> > > 
> > > can't we just hardwire `kgcc' into the build system and be done
> > > with all this kwhich stuff?  It's just a symlink....
> > 
> > And break compilation on all non RedHat 7, non connectiva systems ? 
> > Would you volunteer to handle the support load on l-k that would cause?
> 
> Hardcoding kgcc is definitely not an option. 
> 

In Mdk 7.2+ there is something called 'alternatives' that seems to be
inherited-copied from Debian. I read aboce that RH and Conectiva have it.
It allows
you to have some gcc-2.95, gcc-2.96, and select a default gcc that
points to the one desired. It has defaults and priorities.
Same thing could be done with 'kgcc': kernel needs something called
kgcc, its up to you to set it up.

In my case (mdk), kgcc is a binary from egcs-1.1.2. If I want to try
building a kernel with gcc-2.96, I should uninstall egcs to let
kernel miss kgcc and find gcc, or tweak kernel Makefiles.

(OT: I still dont understand why egcs is still named egcs instead
of gcc-2.91)

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
