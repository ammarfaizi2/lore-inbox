Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135675AbRDXPTJ>; Tue, 24 Apr 2001 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135680AbRDXPS7>; Tue, 24 Apr 2001 11:18:59 -0400
Received: from algernon.satimex.tvnet.hu ([195.38.110.113]:50706 "EHLO
	zeus.suselinux.hu") by vger.kernel.org with ESMTP
	id <S135675AbRDXPSq>; Tue, 24 Apr 2001 11:18:46 -0400
Date: Tue, 24 Apr 2001 17:17:08 +0200 (CEST)
From: Pjotr Kourzanoff <pjotr@suselinux.hu>
To: CaT <cat@zip.com.au>
cc: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <20010425005933.G1245@zip.com.au>
Message-ID: <Pine.LNX.4.31.0104241711410.17653-100000@zeus.suselinux.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, CaT wrote:

> On Tue, Apr 24, 2001 at 04:49:57PM +0200, Pjotr Kourzanoff wrote:
> > > use port 2525 as SMTP port in your MTA. I've succeed to setup such a
> > > configuration.
> >
> >   This requires you to ensure that your MTA is started first on that
> >   port...Might be difficult to achieve reliably in an automatic way
> >   without root privileges :-(
> >
> >   mailuser@foo% /etc/rc.d/init.d/sendmail stop
> >   badguy@foo% ./suck 2525
> >   mailuser@foo% /etc/rc.d/init.d/sendmail start
>
> Not necessarily. While I have no yet used the feature, iptables
> permits firewalling on userid. I presume this includes wether or

  man iptables.

> not a program can listen on a port, right? (and all the other
> fun things).
>
> If so then all you'd have to do is deny external access to port 2525
> and only permit mailuser to listen etc on it and you're set.

  For this to work, you need to hack up iptables on the mail server
  itself as -m owner only works for locally generated packets. And
  even then ./suck will receive on 2525 but will not be able to reply.


