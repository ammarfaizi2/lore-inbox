Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJYSn2>; Thu, 25 Oct 2001 14:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJYSnJ>; Thu, 25 Oct 2001 14:43:09 -0400
Received: from pak200.pakuni.net ([207.91.34.200]:48881 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S275963AbRJYSmu>; Thu, 25 Oct 2001 14:42:50 -0400
Date: Thu, 25 Oct 2001 12:40:43 -0500 (CDT)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: David Ford <david@blue-labs.org>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>, <kuznet@ms2.inr.ac.ru>,
        Julian Anastasov <ja@ssi.bg>, Tim Hockin <thockin@sun.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <3BD7263A.9020100@blue-labs.org>
Message-ID: <Pine.LNX.4.31.0110251234430.32029-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, David Ford wrote:

> That is IMO bad behavior, it didn't use to do this because I have
> scripts that rely on this behavior.

The behaviour that Chris describes below has _always_ occurred. And if you
read Alexey's documentation he states that primary and secondary addresses
are the _intended_ behaviour. If you do not like the behaviour of
primary and secondary addressing then simply use /32 as then _every_
address is it's own primary.

The original thought refers to the old concept of address "class" where is
a "class" (think subnet) went away then there was no need (and indeed
incorrect) behaviour to still be able to have addresses on it. Thus when
the primary address is deleted you should clear all addresses within that
network and so the secondaries are removed. The entire concept of an
"aliased" address is an address that is within a scope. This behaviour of
addresses has nothing to do with coloned interfaces and everything to do
with the definition of scope as applied to the address space of an IP
network.

Again - if you do not like this behaviour do not use the primary/secondary
addressing scopes. Use /32.

> I'll take it up with the author, Alexey.
>
> David
>
> Christopher Friesen wrote:
>
> David Ford wrote:
>
> >Actually it is quite sane.  The tool is not.
> >
> >Switch to 'ip' instead of 'ifconfig', several large distros now include
> >it.  Addresses can be added and removed completely indiscriminately on
> >interfaces.
> >
> >The "ethN:X" is a legacy design that is now deprecated.
> >
>
> Minor issue...if I create (using 'ip') two addresses on the same subnet on the
> same device, one of them is primary and the other is secondary.  If I then
> delete the primary address, the second one goes with it.
>
> I submit that this is bad behaviour.
>
> Chris
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

