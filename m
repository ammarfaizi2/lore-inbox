Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131575AbRAIQD4>; Tue, 9 Jan 2001 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbRAIQDr>; Tue, 9 Jan 2001 11:03:47 -0500
Received: from innerfire.net ([208.181.73.33]:20743 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S131575AbRAIQDm>;
	Tue, 9 Jan 2001 11:03:42 -0500
Date: Tue, 9 Jan 2001 08:06:37 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
cc: Helge Hafting <helgehaf@idb.hist.no>,
        Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <Pine.LNX.4.21.0101090853250.27322-100000@pii.fast.net>
Message-ID: <Pine.LNX.4.10.10101090802060.22357-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Steven N. Hirsch wrote:

> On Tue, 9 Jan 2001, Helge Hafting wrote:
> 
> > Nicolas Noble wrote:
> > [...]
> > As others have told already, this is the ECN problem.
> > 
> > > I noticed the same bug. This is very weired, I can send a list of sites
> > > which I can't connect anymore. 
> > 
> > You have a list?  Send all of them a message stating that they ought
> > to upgrade their firewalls which cause this problem.  Or they
> > will loose customers/visitors.  Cisco already have an upgrade for them,
> > so fixing is dead easy, and they can then boast compatibility with
> > the latest internet standards.  
> > 
> > If they don't care about linux users, tell them that windows eventually
> > will use ECN too.  They definitely don't want to have a ECN problem when
> > that happens.
> 
> After upgrading to kernel 2.4.0, I found myself unable to retrieve mail
> from Adelphia's (2-way cable ISP) POP server.  It took several days to
> figure out that _one_ of their routers was configured to block ECN.  After
> bringing this to the attention of their network engineers, I was informed
> that their policy prohibits making any router changes on the basis of one
> trouble report.  The person I spoke with did NOT try to defend their
> setup, but it was made clear that they'll do nothing until Windows breaks.
> 
> If I were packaging a Linux distribution, I'd be sure to have ECN disabled
> by default, FWIW.
> 

It's not a matter of changing network setup... if those are cisco routers
there are patches to fix the bugs.

Here is what little info I have on the topic (shamelessly ripped from an
earlier email by "Dax Kelson <dax@gurulabs.com>" )


Here is the fix for PIX:
http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds23698

    Bud ID:        CSCds23698
    Headline:      PIX sends RSET in response to tcp connections with ECN
 bits set
    Product:       PIX
    Component:     fw
    Severity:      2            Status:           R [Resolved]
    Version Found: 5.1(1)       Fixed-in Version: 5.1(2.206) 5.1(2.207)
 5.2(1.200)

Here is the fix for Local Director:
http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds40921

Bug Id : CSCds40921
 Headline:  LD rejects syn with reserved bits set in flags field of TCP
hdr
 Product:  ld
 Component: rotor
 Severity: 3                     Status:        R [Resolved]
 Version Found: 3.3(3)           Fixed-in Version: 3.3.3.107


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
