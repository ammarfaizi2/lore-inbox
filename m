Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTCCNjD>; Mon, 3 Mar 2003 08:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTCCNjD>; Mon, 3 Mar 2003 08:39:03 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:25237 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S264984AbTCCNjC>; Mon, 3 Mar 2003 08:39:02 -0500
Date: Mon, 3 Mar 2003 14:49:04 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: IGMP problem with 2.5 kernels
Message-ID: <20030303134904.GA19636@pangsit>
References: <20030210113210.GA4827@pangsit> <20030212215757.GA1393@pangsit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212215757.GA1393@pangsit>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 12 February 2003, Niels den Otter wrote:
> On Monday, 10 February 2003, Niels den Otter wrote:
> > I have tried to run several IP Multicast applications (SDR, Vat,...)
> > with on 2.5 kernels (now running 2.5.59bk3) without succes. Same
> > applications appear to work on 2.4 kernels.
> > 
> > What seems to be happening is that the application binds to the lo
> > interface instead of eth0 so that no IGMP queries are send out on
> > the ethernet interface. I have a small application that tries to
> > listen to address 233.4.5.9 and here is /proc/net/igmp with and
> > without the app  running:
> 
> Did more debugging and disabled my loopback interface to ensure the
> mcast apps don't bind to this interface. strace shows all applications
> go wrong with the same error. Is this kernel related?

In the meantime I have had verious discussion on this subject with
Antonio Querubin and others and I don't know any solution yet.

Is anyone able to use multicast applications on recent 2.5 kernels and
make it send out IGMP joins on an ethernet device?

RFC 1112 says
 If the upper-layer protocol chooses not to identify an outgoing
 interface, a default interface should be used, preferably under the
 control of system management.

In Linux 2.4 kernels this seems to work with adding a route for
224.0.0.0/4 on the desired ethernet interface. This doesn't work in 2.5
kernels however.


Anyone who knows what the problem is and how it can be solved?


Thanks,

Niels
