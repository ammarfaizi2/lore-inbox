Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSANJIu>; Mon, 14 Jan 2002 04:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288731AbSANJIb>; Mon, 14 Jan 2002 04:08:31 -0500
Received: from gw-nl3.philips.com ([212.153.190.5]:1543 "EHLO
	gw-nl3.philips.com") by vger.kernel.org with ESMTP
	id <S288595AbSANJIO>; Mon, 14 Jan 2002 04:08:14 -0500
From: fabrizio.gennari@philips.com
To: jt@hpl.hp.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: PPP over socket?
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFDAD62848.4EE45082-ONC1256B41.00314A4F@diamond.philips.com>
Date: Mon, 14 Jan 2002 10:07:22 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 14/01/2002 10:25:52,
	Serialize complete at 14/01/2002 10:25:52
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(let's hope this time the mail client understands I want to send this in 
plain text!)

I thought that, by changing the socket architecture, the result would be 
independent to the actual implementation of the socket. For example, a 
"PPP over generic socket" could be adapted to "PPP over AF_IRDA socket" 
without having to tear one's hair out implementing the pretty complex 
/dev/irnet virtual TTY. That is a good solution anyway, but it is very 
difficult to port it to different kinds of socket.

What do you exactly mean with "kernel space wrapper"? I guess "user space 
wrapper" is something like VTun (which I tried, and it works like a dream. 
Only, isn't it a bit inefficient to go through user space?)

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800




Jean Tourrilhes <jt@bougret.hpl.hp.com>
12/01/2002 03.17
Please respond to jt

 
        To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Fabrizio Gennari/MOZ/RESEARCH/PHILIPS@EMEA1
Chris Dukes <pakrat@www.uk.linux.org>
        cc: 
        Subject:        Re: PPP over socket?
        Classification: 



Chris Dukes wrote :
> On Fri, Jan 11, 2002 at 10:13:57AM +0100, fabrizio.gennari@philips.com 
wrote:
> > I was wondering whether the socket architecture could be modified in 
order 
> > to support PPP connections over a generic socket (of type SOCK_DGRAM 
or 
> > SOCK_SEQPACKET), by mapping each PPP packet to a socket packet. This 
idea 
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

                 And at the total opposite of the spectrum you have IrNET, 
as
it is implemented in kernekl 2.4.X, that pass PPP packets on an IrDA
socket in the kernel without going through the socket API. But that's
the solution only if you don't mind debugging kernel code...
                 BTW, I don't understand why the socket architecture would 
need
to be modified. You just need a user space or a kernel space wrapper.
                 Regards,

                 Jean




