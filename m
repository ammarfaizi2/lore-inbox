Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbSALCRc>; Fri, 11 Jan 2002 21:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSALCRW>; Fri, 11 Jan 2002 21:17:22 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:18369 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281809AbSALCRK>;
	Fri, 11 Jan 2002 21:17:10 -0500
Date: Fri, 11 Jan 2002 18:17:04 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        fabrizio.gennari@philips.com, Chris Dukes <pakrat@www.uk.linux.org>
Subject: Re: PPP over socket?
Message-ID: <20020111181704.A15819@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Dukes wrote :
> On Fri, Jan 11, 2002 at 10:13:57AM +0100, fabrizio.gennari@philips.com wrote:
> > I was wondering whether the socket architecture could be modified in order 
> > to support PPP connections over a generic socket (of type SOCK_DGRAM or 
> > SOCK_SEQPACKET), by mapping each PPP packet to a socket packet. This idea 
> > is not completely new: somebody raised is in the past, see for example 
> > http://oss.sgi.com/projects/netdev/mail/netdev/msg00180.html or 
> > http://oss.sgi.com/projects/netdev/mail/netdev/msg01127.html .
> 
> vtun already provides this capability in user space.
> (See http://vtun.sourceforge.net/)
> ppp(8) on *BSD also provides this capability in user space as well.
> 
> As memory serves PPPoE on Linux is partially implemented in userspace
> as is, so a partial user space solution for PPPoUDP shouldn't be that
> wretched.

	And at the total opposite of the spectrum you have IrNET, as
it is implemented in kernekl 2.4.X, that pass PPP packets on an IrDA
socket in the kernel without going through the socket API. But that's
the solution only if you don't mind debugging kernel code...
	BTW, I don't understand why the socket architecture would need
to be modified. You just need a user space or a kernel space wrapper.
	Regards,

	Jean

