Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOChx>; Tue, 14 Nov 2000 21:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKOChn>; Tue, 14 Nov 2000 21:37:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:61958 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129045AbQKOChh>; Tue, 14 Nov 2000 21:37:37 -0500
Message-ID: <3A11EEF4.349E5511@timpanogas.org>
Date: Tue, 14 Nov 2000 19:03:32 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        linware@sh.cvut.cz
Subject: Re: NetWare Changing IP Port 524
In-Reply-To: <CDB246E6CB3@vcnet.vc.cvut.cz> <3A11A0AB.92B1109D@timpanogas.org> <20001114205629.B5133@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Gregory Maxwell wrote:
> 
> On Tue, Nov 14, 2000 at 01:29:31PM -0700, Jeff V. Merkey wrote:
> > Hopefully, sanity will rule out here.  I information being leaked from
> > what I reviewed was the ability for a hacker to exploit port 524 and use
> > it
> > to obtain a local copy of the entire routing table for other IP servers
> > INSIDE an organization (which is a huge hole).
> 
> That is obviously the hole as it is clearly not the intended function of the
> service. However, anyone who depends on the secrecy of their IP routing
> tables or overall network topology for security has bigger problems then
> some stupid Netware bug.

Greg,

The TCPIP implementation of NCP is little more than the existing RIP/SAP
and NCP protocols enveloped inside of UDP/SLP.  The problem has nothing
to do with IP routing, but the ability
to send envoloped RIP/SAP requests into port 524, and getting a complete
topology description of the other side of a NetWare server being used as
a firewall.  It would be kind of like opening a port on Linux, then
letting people come into the server with root file read/write and
letting
them read the network topology on the other side.  What's nasty about
this problem is that it would give any internet hackers the ability to
discover the network topology (including which servers host NDS master
and replica databases).  Not very secure.  The concern for Petr is if in
fixing this hole, Novell breaks features Petr needs.  I doubt they can
change it at this point, other than allow firewall servers to turn it
off to the external world.  As Petr pointed out, closing this port will
break all the clients, including theirs.  To make a change of this
magnitude would require they rev their clients and servers (and break
access to the entire installed base).  I provided Petr the URL so he can
track what changes they post.

You misunderstood, I think.  

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
