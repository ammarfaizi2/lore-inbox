Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbRC0URk>; Tue, 27 Mar 2001 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131532AbRC0URc>; Tue, 27 Mar 2001 15:17:32 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9745
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131531AbRC0URU>; Tue, 27 Mar 2001 15:17:20 -0500
Date: Tue, 27 Mar 2001 12:15:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Richard A. Smith" <rsmith@bitworks.com>
cc: "Padraig@AnteFacto.com" <Padraig@AnteFacto.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compact flash disk and slave drives in 2.4.2
In-Reply-To: <MDAEMON-F200103271328.AA284497MD89819@bitworks.com>
Message-ID: <Pine.LNX.4.10.10103271200100.17821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hdx=flash is only a flag to deal with flash.

a better description is probe-slave-with-master-flash, or
to-hell-with-flash-go-look.


On Tue, 27 Mar 2001, Richard A. Smith wrote:

> On Tue, 27 Mar 2001 09:17:48 -0800 (PST), Andre Hedrick wrote:
> 
> >not acceptable.  If you have a complain take it to CFA commitee and have
> >them fix it.
> 
> Well my only real complaints are that 1) It was done silently.. 2) I could not override it 
> w/o a code mod.  Both of which are contrary to what I am accustom to when using linux.

Nothing is done privately or silently, sometime I try to second guess the
needs and add things so that when the question pops up, I can say, gee:
This was the guy that was going to ask that question, glad I had an early
answer.

It was addressed some time ago when there was a case of a firewall box
using two CFA's in a HOST->CFA thingy. This was where hda/hdb were both
CFA's

Override a probe that can hang a system is not going to happen.
You override the blocking flag first, then the generic overide is not
needed.

> >Logically treated, is true, but again CFA does not follow the rules of
> >what the ATA committee gives them, and I refuse to break rules as the
> >standard model.  Rule breaking are exceptions.
> >
> >Also show me a case where a laptop will do master/slave in CFA.
> 
> Agreed... If CF does some wierd stuff then you shouldn't make the ATA driver break any 
> rules for it.. that wasn't what I was asking for.  Just some why's and perhaps a message 
> that indicated what it was doing.

The problem is that body does more things outside a commitee than it does
inside.  So the docs do not reflect reality or impose usage rules.

> As for the laptops.. What laptops are you refering to?  Don't most of them have some sort 
> of std laptop HD or an ibm microdrive thing.  CF is terribly expensive compared to 
> mechanical HDs.

CFA is dropped into a pcmica/cardbus thingy.

Also there are no CFA's which are ATA devices by the definition, they
require a host-bridge to transport the signal.  Handling host-bridges is
the problem.  As more and stranger usages of these bridges happen the more
screwy thing get.

> >/linux/drivers/ide/ide.c
> >* "hdx=flash"          : allows for more than one ata_flash disk to be
> >*                              registered. In most cases, only one device
> >*                              will be present.
> 
> Perhaps I missed something.. but this won't work for my original case.  I have a CF as hda 
> and I was trying to hook up a mechanical HD as the slave.  I specified hdb=c,h,s on the 
> command line but it was ignored.

Again it is only a flag that allows for probing of a slave device if the
primary is a flash.

Now if the reactions/responses are wrong then it needs a fix, but to allow
systems to hang because of a nonexistant device is not something Linus
will allow, period.

> 
> --
> Richard A. Smith                         Bitworks, Inc.               
> rsmith@bitworks.com               501.846.5777                        
> Sr. Design Engineer        http://www.bitworks.com   
> 
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

