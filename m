Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRCWRjk>; Fri, 23 Mar 2001 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbRCWRj3>; Fri, 23 Mar 2001 12:39:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27384 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S131308AbRCWRjT>; Fri, 23 Mar 2001 12:39:19 -0500
Message-ID: <3ABB892C.A47D6BA9@mvista.com>
Date: Fri, 23 Mar 2001 09:34:36 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe barbe <christophe.barbe@lineo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100 question: why SCBCmd byte is 0x80?
In-Reply-To: <3ABA68EC.89B2DE99@mvista.com> <20010323115535.A16497@pc8.inup.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbe wrote:
> 
> Which kernel are you using.
> 
> I've had a similar problem with 2.2.18.
> I've backported 2.2.19pre changes to it.
> (i.e. apply on 2.2.18 a diff of the file drivers/net/eepro100.c made between 2.2.18 and the last 2.2.19pre)
> And since I've never seen this problem again.
> 
> Christophe
> 

Kernel is 2.4.2.  It is a MIPS machine.

I don't really think it is a driver problem, because the same dirver works
fine on many other boards (including MIPS boards).  In addition, I also tested
with tulip cards and I had the same symptom.  I am convinced it is a low-level
problem (bus timing, PCI setting, buggy hardware, etc).

On the other hand, it could be a driver problem which is only exposed in this
particular board, although very unlikely.

BTW, does the eepro100 patch for 2.2.19pre apply to 2.4.2?  Or it is already
in it?

Thanks.

Jun

> On jeu, 22 mar 2001 22:04:45 Jun Sun wrote:
> >
> > I am trying to get netgear card working on a new (read as potentially buggy
> > hardware) MIPS board.
> >
> > The eepro100 driver basically works fine.  It is just after a little while
> > (usually 2 sec to 15 sec) network communication suddenly stops and I start see
> > error message like "eepro100: wait_for_cmd_done timeout!".
> >
> > I looked into this, and it appears that the SCBCmd byte in the command word
> > has value 0x80 instead of the expected 0.  I looked at the Intel manual, and
> > it says nothing about the value being 0x80.
> >
> > Does anybody have a clue here?  I suspect some timing is wrong or a buggy PCI
> > controller.
> >
> > Please cc your reply to my email address.  Thanks.
> >
> > Jun
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> --
> Christophe Barbé
> Software Engineer
> Lineo High Availability Group
> 42-46, rue Médéric
> 92110 Clichy - France
> phone (33).1.41.40.02.12
> fax (33).1.41.40.02.01
> www.lineo.com
