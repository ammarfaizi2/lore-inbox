Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTHQP53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270346AbTHQP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:57:29 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:54788 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S270345AbTHQP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:57:28 -0400
Message-ID: <011a01c364d8$44be1f90$c801a8c0@llewella>
From: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Carlos Velasco" <carlosev@newipnet.com>
Cc: "Lamont Granquist" <lamont@scriptkiddie.org>,
       "Bill Davidsen" <davidsen@tmr.com>,
       "David S. Miller" <davem@redhat.com>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>, <netdev@oss.sgi.com>,
       <linux-net@vger.kernel.org>, <layes@loran.com>, <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com> <20030728213933.F81299@coredump.scriptkiddie.org> <200308171509570955.003E4FEC@192.168.128.16> <200308171516090038.0043F977@192.168.128.16> <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk> <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Sun, 17 Aug 2003 17:57:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What wonders me about the behaviour is that it is not consistent.

When I have the following situation: a box with twon nics, one 192.168.1.1,
ethernet adr aa , the other 192.168.1.2 ethernet adr bb

When I do an ARP request for 192.168.1.2, both respond. aa as wel as bb

But if I do another request for 192.168.1.2, and I direct it to the aa NIC,
it does not respond. Unless I turn on packet_forwarding (i.e. routing).
Remember, ARP is not routable, or shouldn't be, yet it is treated as such.

Regards,
Bas



