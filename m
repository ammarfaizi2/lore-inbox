Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262321AbRERN4f>; Fri, 18 May 2001 09:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbRERN4Z>; Fri, 18 May 2001 09:56:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262321AbRERN4L>; Fri, 18 May 2001 09:56:11 -0400
Subject: Re: [newbie] timer in module
To: sebastien.person@sycomore.fr (sebastien person)
Date: Fri, 18 May 2001 14:53:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (liste noyau linux)
In-Reply-To: <20010518152834.7308d344.sebastien.person@sycomore.fr> from "sebastien person" at May 18, 2001 03:28:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150kgt-00077W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Your timer is like an interrupt (in fact it runs from one) so you will
> need
> > to lock it against transmit, receive, multicast list loads and get_stats
> > all of which can happen at the same time.
> 
> So I must disable interrupt when I handle another function like receive
> etc ...

That depends on the nature of your hardware. Well designed hardware keeps
the various functional modules apart. On older or poorly designed hardware
that may not be the case - eg ythe old NE2000 cards have register windows
and the various code paths lock the chip so that somebody does not change
register window on someone else.

