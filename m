Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRCXAqr>; Fri, 23 Mar 2001 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRCXAqi>; Fri, 23 Mar 2001 19:46:38 -0500
Received: from ohiper1-63.apex.net ([209.250.47.78]:21508 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131446AbRCXAq1>; Fri, 23 Mar 2001 19:46:27 -0500
Date: Fri, 23 Mar 2001 18:49:55 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 question: why SCBCmd byte is 0x80?
Message-ID: <20010323184955.A6184@hapablap.dyn.dhs.org>
In-Reply-To: <3ABA68EC.89B2DE99@mvista.com> <20010323115535.A16497@pc8.inup.com> <3ABB892C.A47D6BA9@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABB892C.A47D6BA9@mvista.com>; from jsun@mvista.com on Fri, Mar 23, 2001 at 09:34:36AM -0800
X-Uptime: 6:41pm  up 51 min,  1 user,  load average: 2.30, 2.17, 1.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a similar problem with the onboard network card of a Sony
Vaio Laptop.  I haven't tracked it down as far as you can; how can I
confirm its the same problem as yours?

On Fri, Mar 23, 2001 at 09:34:36AM -0800, Jun Sun wrote:
> christophe barbe wrote:
> > 
> > Which kernel are you using.
> > 
> > I've had a similar problem with 2.2.18.
> > I've backported 2.2.19pre changes to it.
> > (i.e. apply on 2.2.18 a diff of the file drivers/net/eepro100.c made between 2.2.18 and the last 2.2.19pre)
> > And since I've never seen this problem again.
> > 
> > Christophe
> > 
> 
> Kernel is 2.4.2.  It is a MIPS machine.
> 
> I don't really think it is a driver problem, because the same dirver works
> fine on many other boards (including MIPS boards).  In addition, I also tested
> with tulip cards and I had the same symptom.  I am convinced it is a low-level
> problem (bus timing, PCI setting, buggy hardware, etc).
> 
> On the other hand, it could be a driver problem which is only exposed in this
> particular board, although very unlikely.
> 
> BTW, does the eepro100 patch for 2.2.19pre apply to 2.4.2?  Or it is already
> in it?
> 
> Thanks.
> 
> Jun
> 
> > On jeu, 22 mar 2001 22:04:45 Jun Sun wrote:
> > >
> > > I am trying to get netgear card working on a new (read as potentially buggy
> > > hardware) MIPS board.
> > >
> > > The eepro100 driver basically works fine.  It is just after a little while
> > > (usually 2 sec to 15 sec) network communication suddenly stops and I start see
> > > error message like "eepro100: wait_for_cmd_done timeout!".
> > >
> > > I looked into this, and it appears that the SCBCmd byte in the command word
> > > has value 0x80 instead of the expected 0.  I looked at the Intel manual, and
> > > it says nothing about the value being 0x80.
> > >
> > > Does anybody have a clue here?  I suspect some timing is wrong or a buggy PCI
> > > controller.
> > >
> > > Please cc your reply to my email address.  Thanks.
> > >
> > > Jun
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > --
> > Christophe Barbé
> > Software Engineer
> > Lineo High Availability Group
> > 42-46, rue Médéric
> > 92110 Clichy - France
> > phone (33).1.41.40.02.12
> > fax (33).1.41.40.02.01
> > www.lineo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
