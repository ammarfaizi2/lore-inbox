Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130910AbQL1DPV>; Wed, 27 Dec 2000 22:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbQL1DPL>; Wed, 27 Dec 2000 22:15:11 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:21008 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S130910AbQL1DPG>; Wed, 27 Dec 2000 22:15:06 -0500
Date: Wed, 27 Dec 2000 21:10:51 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Joaquin Rapela <rapela@sipi.usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rapela@sipi.usc.edu: SYN_SENT block]
Message-ID: <20001227211051.A22369@alcove.wittsend.com>
Mail-Followup-To: Joaquin Rapela <rapela@sipi.usc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001227173810.A27194@confucius.usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20001227173810.A27194@confucius.usc.edu>; from rapela@sipi.usc.edu on Wed, Dec 27, 2000 at 05:38:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 05:38:10PM -0800, Joaquin Rapela wrote:
> I forgot to mention. I am running RedHat 6.2 and the kernel release is
> 2.2.14-5smp.

	It depends upon what that spider is doing.  You didn't exactly
elaborate on what it was.  Is it a "web spider" or a "spam harvestor"
(web spider looking for E-Mail addresses) or something else?  You cross
into the wrong areas, and some sites will cut you off (warning ALWAYS
obey robots.txt).  If you get cut off by a firewall, you will most often
get dropped and every SYN packet you send will get ignored and you
will be stuck in SYN SENT state till you time out.  This is deliberate
on our part.  Someone trespassing out of bounds in my network gets
cut off at the firewall and gets nothing back...  That does several
things that I WANT.  It blocks them from determining anything residing
behind my firewall, it blocks them from determining the state of
ports and servers, it slows them down when scanning my address
space, and it makes my entire network look like it is totally
unpopulated (and uninteresting).  I like that...  :-)

	Access the wrong URL and some IDS (Instrusion Detection System)
fires and you can no longer contact anything in an entire netblock.  You 
won't even get an error back.  Hell!  We don't want to tell you we are
refusing to talk to you.  We want you to ignore us and go away like we
didn't even exist!

	That being said, if you reach a dead site (not currently reachable
for one reason or another) this can also happen.  Normally you might
expect an ICMP UNREACHABLE.  If the target site is behind a firewall
that blocks ICMP UNREACHABLE {HOST|NET_UNREACHABLE} (lots do this) you
will hang in that state till you time out because you never got an
error back from a down system.

	That's life in the big city...  You run a spider, you can expect
that.  Sites will be hostile to you and cut you off.  If you trespass
out of bounds into some honey-pot or sugarplum, you get what you
deserve, that's why we set these traps up on our servers.  My robots.txt
will warn off anyone legitimate.  Some spider straying beyond what is
allowed by robots.txt is going to hit a trap and be blackholed.  It's
exactly what it deserves.

> Joaquin

> ----- Forwarded message from Joaquin Rapela <rapela@sipi.usc.edu> -----

> Date: Wed, 27 Dec 2000 16:25:18 -0800
> From: Joaquin Rapela <rapela@sipi.usc.edu>
> To: linux-kernel@vger.kernel.org
> Subject: SYN_SENT block
> User-Agent: Mutt/1.2.5i
> 
> Hello,
> 
> I am not a linux kernel guy. I am running a spider that sometimes gets blocked
> for long periods of time.  I run a "netstat -nto" and I observe a socket in 
> state SYS_SENT that seems to be blocked. Its timer keeps on incrementing. 

	Yup...  You sent a SYN (and maybe a couple of retries) and got
absolutely nothing back.  Zip.  Zero.  Ziltch.  Of course it's timer
keeps incrementing.  How else would it time out?

> Is there any way to avoid this blocking? Is this a bug in the kernel or
> something wrong in my TCP/IP configuration/settings.

	Neither.  You are working fine.  You are being deliberately
torpedoed by systems or firewalls configured to return no error and
to ignore you.  Deal.

> Thanks in advance, Joaquin


> ----- End forwarded message -----
> 
> -- 
> Joaquin Rapela
> PhD Student, Signal and Image Processing Institute
> University of Southern California
> 3740 McClintock Ave, EEB 424
> Los Angeles, CA 90089-2564
> email: rapela@sipi.usc.edu
> tel:   (213) 740-6430
> fax:   (213) 740-4651
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
