Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131315AbQKNVDy>; Tue, 14 Nov 2000 16:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbQKNVDo>; Tue, 14 Nov 2000 16:03:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22022 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131315AbQKNVDe>; Tue, 14 Nov 2000 16:03:34 -0500
Message-ID: <3A11A0AB.92B1109D@timpanogas.org>
Date: Tue, 14 Nov 2000 13:29:31 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, linware@sh.cvut.cz
Subject: Re: NetWare Changing IP Port 524
In-Reply-To: <CDB246E6CB3@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Vandrovec wrote:
> 
> On 14 Nov 00 at 12:11, Jeff V. Merkey wrote:
> 
> > If you are relying on port 524 to get SAP information for NCPFS over
> > TCPIP, you may want to track this since it appears Novell will be
> > patching this port to close a security flaw.  I
> > added the tracking URL so you can review what changes they are
> > proposing.  I think what they
> > are proposing as an immediate patch may break NCPFS -- you will need to
> > check.
> 
> I think that it is unavoidable. Either you can browse network resources,
> through SAP, NDS, DNS, SLP, bindery - and you also disclose
> informations - or you cannot browse network and users will get angry
> from typing 80 characters FQDN names...
> 
> You can limit it by removing [Search] right for [Public] from your NDS -
> and I believe that it is only correct solution. Of course every NDS server
> must be able to tell to [public] address of at least one other server
> nearest to [root], as client must be able to find where r/w replica
> resides - and because of you know that there is [root] object in every
> tree, you can find also [root] owner IP/IPX address. But if even knowing
> of address of server can kill your network, you should already firewall
> everything out.
> 
> > Novell's NetWare operating system contains a flaw that allows
> > system information to be leaked via TCP port 524 in pure IP
> > configurations. When NetWare is used in a mix Microsoft
> > environment, the Novell operating system leaks data via Service
> > Advertising Protocol (SAP). Other third-party applications
> > compound the problem as well. A hacker can use the data to gain
> > knowledge on the inner workings of the affected system. It is
> > recommended that port 524 be blocked to prevent any leaks.
> 
> Yeah. They forgot to note that after blocking port 524 nobody
> can connect to server from outer world. They could say in less
> words that Netware and IP are not on same boat ;-) I think they
> should fix buffer overflows and possible abends in their NCP engine,
> and issue warnings about not giving [Search] rights to [Public]
> instead of blocking whole world from Netware servers.


Hopefully, sanity will rule out here.  I information being leaked from
what I reviewed was the ability for a hacker to exploit port 524 and use
it
to obtain a local copy of the entire routing table for other IP servers
INSIDE an organization (which is a huge hole). 

Jeff 

> 
> BTW, in our tree not-logged-in object does not see anything, except
> few objects which have explicitly granted visibility for [public].
> But maybe that I misunderstood their information... If they are
> talking about that information learned through SLP/SAP/NDS are
> available through SLP/SAP/NDS, I do not see anything wrong with it.
> If hacker can ask this server, it could also ask directly to source
> of that information, unless your server is also serving as firewall
> (and if it is, you should visit filtering section in FILTCFG.NLM...)
>                                             Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
