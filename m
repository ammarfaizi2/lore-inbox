Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136852AbRASV76>; Fri, 19 Jan 2001 16:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136857AbRASV7j>; Fri, 19 Jan 2001 16:59:39 -0500
Received: from mms1.broadcom.com ([63.70.210.58]:2321 "HELO mms1.broadcom.com")
	by vger.kernel.org with SMTP id <S136852AbRASV7c>;
	Fri, 19 Jan 2001 16:59:32 -0500
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Message-ID: <E1EBEF4633DBD3118AD1009027E2FFA00109BEDD@mail.sv.broadcom.com>
From: gmo@broadcom.com
To: "'Carles Pina i Estany'" <is08139@salleURL.edu>,
        linux-kernel@vger.kernel.org
cc: "'linux-tp600@icemark.ch'" <linux-tp600@icemark.ch>
Subject: RE: PCMCIA Cards on 2.4.0
Date: Fri, 19 Jan 2001 13:59:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 16766748117112-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem with a Thinkpad 600e:

The machine has RedHat6.2, and the original kernel
(2.2.14-5) as well as every 2.4.0-test* kernel I've
tried (test5, test9, test10 and test12) have had
no trouble with the PCMCIA (actually Cardbus)
card I use (a 3Com 3C575, but I don't think it
has anything to do with the card itself).

Well, 2.4.0 does not seem to be able to talk to
the card. The first sign of trouble is the lines:

cs: socket c13d4800 timed out during reset.
	Try increasing setup_delay.

at the point where other kernels say instead:

cs: cb_alloc(bus 5): vendor 0x10b7, device 0x5057

and so the former does not seem to be able to access
the card while the others are happy.

All of this is with 2.4 kernels that include all the
necessary pieces (no modules), which makes it harder
to go change the setup_delay. I can make the PCMCIA
stuff into modules, but the point is that neither
setup_delay nor any other of the default values for
the module parameters changed between test12 and
release, so I'm not sure that it will really make
a difference.

One other thing I did try: If I eject and re-insert
the card after the system is up, it then starts working.
So I actually have a workaround, but I'd like to know
what is really happening and how to fix it.

Any suggestions?

TIA,

Gmo.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
