Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRATRli>; Sat, 20 Jan 2001 12:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbRATRlL>; Sat, 20 Jan 2001 12:41:11 -0500
Received: from dusdi4-145-253-116-193.arcor-ip.net ([145.253.116.193]:1540
	"EHLO al.romantica.wg") by vger.kernel.org with ESMTP
	id <S130636AbRATRlD>; Sat, 20 Jan 2001 12:41:03 -0500
Date: Sat, 20 Jan 2001 14:33:29 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: gmo@broadcom.com
Cc: "'Carles Pina i Estany'" <is08139@salleURL.edu>,
        linux-kernel@vger.kernel.org,
        "'linux-tp600@icemark.ch'" <linux-tp600@icemark.ch>
Subject: Re: PCMCIA Cards on 2.4.0
Message-ID: <20010120143329.A901@al.romantica.wg>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	gmo@broadcom.com, 'Carles Pina i Estany' <is08139@salleURL.edu>,
	linux-kernel@vger.kernel.org,
	"'linux-tp600@icemark.ch'" <linux-tp600@icemark.ch>
In-Reply-To: <E1EBEF4633DBD3118AD1009027E2FFA00109BEDD@mail.sv.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E1EBEF4633DBD3118AD1009027E2FFA00109BEDD@mail.sv.broadcom.com>; from gmo@broadcom.com on Fri, Jan 19, 2001 at 01:59:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used to have the same problem. Do you have ACPI enabled? Disabling it
fixed it for me (btw: it does seem to matter what kind of card you use.
I have only heard of networking cards causing trouble so far).

Jens

On Fri, Jan 19, 2001 at 01:59:28PM -0800, gmo@broadcom.com wrote:
> I have a similar problem with a Thinkpad 600e:
> 
> The machine has RedHat6.2, and the original kernel
> (2.2.14-5) as well as every 2.4.0-test* kernel I've
> tried (test5, test9, test10 and test12) have had
> no trouble with the PCMCIA (actually Cardbus)
> card I use (a 3Com 3C575, but I don't think it
> has anything to do with the card itself).
> 
> Well, 2.4.0 does not seem to be able to talk to
> the card. The first sign of trouble is the lines:
> 
> cs: socket c13d4800 timed out during reset.
> 	Try increasing setup_delay.
> 
> at the point where other kernels say instead:
> 
> cs: cb_alloc(bus 5): vendor 0x10b7, device 0x5057
> 
> and so the former does not seem to be able to access
> the card while the others are happy.
> 
> All of this is with 2.4 kernels that include all the
> necessary pieces (no modules), which makes it harder
> to go change the setup_delay. I can make the PCMCIA
> stuff into modules, but the point is that neither
> setup_delay nor any other of the default values for
> the module parameters changed between test12 and
> release, so I'm not sure that it will really make
> a difference.
> 
> One other thing I did try: If I eject and re-insert
> the card after the system is up, it then starts working.
> So I actually have a workaround, but I'd like to know
> what is really happening and how to fix it.
> 
> Any suggestions?
> 
> TIA,
> 
> Gmo.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Jens Taprogge

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
