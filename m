Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUC1SLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUC1SLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:11:07 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:13840 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262286AbUC1SK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:10:59 -0500
Date: Sun, 28 Mar 2004 20:09:56 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Problems with my parport (and printer)
Message-ID: <20040328180956.GA6260@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <20040325115131.GA12195@DervishD> <20040328155134.GG27362@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040328155134.GG27362@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jan :)

 * Jan-Benedict Glaw <jbglaw@lug-owl.de> dixit:
> > kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
> > kernel: parport0: Printer, Lexmark International Lexmark Optra E312
> > kernel: lp0: using parport0 (interrupt-driven).
> > kernel: lp0: console ready
> >     It works ok, BTW... The problem is that, when the printer is
> > switched of and I try to print something, the print command just
> > blocks, no error, no messages, nothing. I use a shell function to
> First of all, if you want to do normal printing, you shouldn't switch on
> LP console. From there on, all kernel debug output (as seen in
> /var/log/kern.log and outputted with "dmesg") would be sent to the
> printer, what isn't exactly what you want to have.

    That's right, but LP console must be activated at boot time (or
at module-loading time) AFAIK, so this is not the problem.

> >     Why this operation doesn't fail? IMHO, it should fail with
> > ENODEV, because parport can work (the parallel port is there...), but
> > lp shouldn't (the printer is switched off...).
> Another gotcha may be that your printer doesn't easily accept commands.
> Many printers don't do that nowadays. Some are dumb GDI-Printerts
> (Windows-only, that is...), some nees specific wake-up sequences.

    This printer (Lexmark Optra E312) is not a winprinter, and the
problem is not related to commands. The printer works fine, I have no
problems with that. My problem arises when the printer is offline:
when I send data to the printer and it is not connected, the command
used to send that data doesn't fail, just waits forever...

    Thanks for your answer anyway :) Really I'm not familiar with the
parallel port :(

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
