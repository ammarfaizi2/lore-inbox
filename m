Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRGaSUP>; Tue, 31 Jul 2001 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269394AbRGaSUF>; Tue, 31 Jul 2001 14:20:05 -0400
Received: from srvr3.telecom.lt ([212.59.0.2]:1083 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269395AbRGaST4>;
	Tue, 31 Jul 2001 14:19:56 -0400
Message-Id: <200107311820.UAA1793604@mail.takas.lt>
Date: Tue, 31 Jul 2001 20:13:08 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: Transparent proxies and binding to foreign addresses
To: Julio Sanchez Fernandez <j_sanchez@stl.es>
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <m2lmlcakrq.fsf@j-sanchez-p.stl.es>
	<m2lmlcakrq.fsf@j-sanchez-p.stl.es>
	<200107270215.EAA1376016@mail.takas.lt>
 <m2hevyaljp.fsf@j-sanchez-p.stl.es>
In-Reply-To: <m2hevyaljp.fsf@j-sanchez-p.stl.es>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 27 Jul 2001 09:16:58 +0200 Julio Sanchez Fernandez <j_sanchez@stl.es> wrote:

JSF> > I don't know if it is useful for you, but http://www.mcknight.de/jftpgw
JSF> > supports transparent proxy for Linux 2.4.x kernel.
JSF> 
JSF> Only impersonating the server.  What does not work is impersonating
JSF> the client and that cannot be fixed from user space.
JSF> 
JSF> > BTW, do you know of any port forwarder which works with 2.4 kernel in
JSF> > transparent mode? I tried mmtcpfwd and portfwd, but both do not work.
JSF> 
JSF> Anyone that used TCP and worked before should be easy to adapt by just
JSF> finding where it got the destination address with getsockname and
JSF> using the getsockopt with SOL_ORIGINAL_DST thing.  Apparently, UDP is
JSF> out as well, though I don't care about that currently.
JSF> 
JSF> Add to your list more forwarders like transproxy and those (plug-gw in
JSF> particular) in the TIS (NAI) FWTK with the transparency patches
JSF> described at http://www.fwtk.org
JSF> 
JSF> While none of them has been adapted to 2.4, they should be easy as I
JSF> said above.
JSF> 
JSF> And as long as you don't care what origin address the server sees,
JSF> that's alright.  But all connections now seem to come from the proxy.
JSF> And that does not let you do things like differentiated services,
JSF> access control or audit.  Even user support becomes a mess.

Do you mean that even if I adapt them as you say, the receiving end will see
connection orriginating from the proxy instead of the real address?
I'm asking as these 2 port forwarders I tried work with 2.4 kernel in non-transparent
mode, i.e. connections seem to come from the proxy, what I need is connection
to be seen to come from real originating IP.

Regards,
Nerijus


