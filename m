Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQLTRV5>; Wed, 20 Dec 2000 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLTRVs>; Wed, 20 Dec 2000 12:21:48 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:45976 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129480AbQLTRVj>; Wed, 20 Dec 2000 12:21:39 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Date: Wed, 20 Dec 2000 08:51:34 -0800 (PST)
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.31.0012200848430.180-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Michael Rothwell wrote:

> Date: Wed, 20 Dec 2000 11:30:15 -0500
> From: Michael Rothwell <rothwell@holly-springs.nc.us>
> To: Michael H. Warfield <mhw@wittsend.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: iptables: "stateful inspection?"
>
> "Michael H. Warfield" wrote:
> >         I think that's more than a little overstatement on your
> > part.  It depends entirely on the application you intend to put
> > it to.
>
> Fine. How do I make FTP work through it? How can I allow all outgoing
> TCP connections without opening the network to inbound connections on
> the ports of desired services?
>

for the issue of outbound TCP connections you can set ipchains filters
based on the Syn flag to prevent inbound connections.

for FTP I don't know off the top of my head how to do it when not
masquerading, when NAT is turned on load the FTP masq helper module and it
will allow you to do ftp out with no problems.

the real point that you need the stateful filtering is on UDP ports. for
that again I don't know any way when not doing NAT, but when NAT is
enabled it does do basic stateful filtering (but watch out for timeouts)

David Lang

> >         Yes it does.  It's clearly stated in all the documentation
> > on netfilter and in it's design.  Read the fine manual (or web site)
> > and you would have uncovered this (or been run over by it) for yourself.
> >
> >         http://netfilter.filewatcher.org/
>
> Thanks.
>
> -M
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
