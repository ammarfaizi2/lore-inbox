Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130877AbRATRv1>; Sat, 20 Jan 2001 12:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131169AbRATRvO>; Sat, 20 Jan 2001 12:51:14 -0500
Received: from vela.salleURL.edu ([130.206.42.85]:6917 "EHLO vela.salleURL.edu")
	by vger.kernel.org with ESMTP id <S130877AbRATRvE>;
	Sat, 20 Jan 2001 12:51:04 -0500
Date: Sat, 20 Jan 2001 19:05:49 +0000 (GMT)
From: Carles Pina i Estany <is08139@salleURL.edu>
To: <gmo@broadcom.com>
cc: <linux-kernel@vger.kernel.org>,
        "'linux-tp600@icemark.ch'" <linux-tp600@icemark.ch>
Subject: RE: PCMCIA Cards on 2.4.0
In-Reply-To: <E1EBEF4633DBD3118AD1009027E2FFA00109BEDD@mail.sv.broadcom.com>
Message-ID: <Pine.LNX.4.30.0101201900100.10134-100000@vela.salleURL.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My problem was an other problem.

With Kernel 2.4.0test11 and 2.4.0test12, I compile with PCMCIA options
built in the Kernel (not as modules).

Works fine, I start Linux and the PCMCIA that was inserted was recognized
without problems (I think that I could not change PCMCIA because then
don't work, I am not sure)

With Kernel 2.4.0 final, with the same options, I start Linux and don't
work.

Then, with the help of Christian Gennerat, I see (on /var/log/daemon) that
my cardmgr searchs for the module of my card (serial_cs.o, etc.; I haven't
the laptop here). After it, I compile with the PCMCIA suport in kernel
but with the drivers of my cards as module.

Now works fine, I can change the cards without restart :-)

The question is, why with kernel 2.4.0test12 and test11 this options works
fine; and with final release not?

Thank you very much, I hope that my experience help anybody.

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

----
Carles Pina i Estany
   E-Mail: cpina@linuxfan.com || #ICQ: 14446118 || Nick: Pinux
   URL: http://www.salleurl.edu/~is08139
   TELEFONICA S.A  "Siempre te dejaremos colgado"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
