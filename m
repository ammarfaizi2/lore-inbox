Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbQJ1UBj>; Sat, 28 Oct 2000 16:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130740AbQJ1UB3>; Sat, 28 Oct 2000 16:01:29 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:54535 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S130462AbQJ1UBL>; Sat, 28 Oct 2000 16:01:11 -0400
Message-ID: <39FB2F90.80A5F931@a2zis.com>
Date: Sat, 28 Oct 2000 21:57:04 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: No IRQ known for interrupt pin A of device 00:0f.0]
In-Reply-To: <39FB2BCF.64A80D88@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Remi Turk wrote:
> >
> > Jeff Garzik wrote:
> > >
> > > Ok, after fixing a bad interaction where the Web server was trying to
> > > run dump_pirq as a CGI script, dump_pirq can be retrieved from
> > >
> > >         http://gtf.org/garzik/kernel/files/dump_pirq
> >
> > :-)
> >
> > I just posted pcmcia-cs dump_pirq's output.
> 
> Same thing :)   I posted pcmcia_cs's dump_pirq as a convenience so
> others wouldn't have to download and extract the tarball.
> 
> Attached below is a message I just sent to someone else who is having
> the same problem as you.  Would it be possible for you to try the stuff
> I suggest in the message as well?
> 
> Thanks,
> 
>         Jeff
> 
> --
> Jeff Garzik             | "Mind if I drive?"  -Sam
> Building 1024           | "Not if you don't mind me clawing at the
> MandrakeSoft            |  dash and shrieking like a cheerleader."
>                         |                     -Max
> 
>   ------------------------------------------------------------------------
> 
> Subject: Re: No IRQ known for interrupt pin A of device 00:0f.0
> Date: Sat, 28 Oct 2000 15:38:49 -0400
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> Organization: MandrakeSoft
> To: Burton Windle <burton@fint.org>
> CC: andre@linux-ide.org, Linus Torvalds <torvalds@transmeta.com>,
>      mj@ucw.cz
> References: <Pine.LNX.4.21.0010281456180.9491-100000@fint.staticky.com>
> 
> Ok, the problem is that you have an interrupt router table for your Ali
> 1533, but no interrupt router entry for your IDE device.  That's why
> pci_enable_device is failing.
> 
> Would you mind testing two kernel patches for me?  Both of these changes
> should be attempted separately in 2.4.0-test10-pre6, and -without-
> Andre's change.
> 
> The first change attempts to build an interrupt router entry for you, if
> none is available.  I am most interested if this works.
> 
> The second change simply ignores any pci_enable_device error returns,
> and assumes that the IDE subsystem will pick up the pieces.
> 
> Remember, do not apply both of these changes at the same time...
> 
> Thanks,
> 
>         Jeff

It's compiling the first kernel now, but I don't think I'll have any
results
before tomorrow. What changes from Andre do you mean?

-- 
Linux 2.4.0-test10-pre6 #1 Sat Oct 28 14:15:54 CEST 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
