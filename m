Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbRFMJkr>; Wed, 13 Jun 2001 05:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbRFMJkh>; Wed, 13 Jun 2001 05:40:37 -0400
Received: from Expansa.sns.it ([192.167.206.189]:23309 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S262681AbRFMJk0>;
	Wed, 13 Jun 2001 05:40:26 -0400
Date: Wed, 13 Jun 2001 11:40:17 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Ben Greear <greearb@candelatech.com>
cc: <landley@webofficenow.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Hour long timeout to ssh/telnet/ftp to down host?
In-Reply-To: <3B26CD5B.47002360@candelatech.com>
Message-ID: <Pine.LNX.4.33.0106131138390.22415-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2001, Ben Greear wrote:

> Rob Landley wrote:
> >
> > I have scripts that ssh into large numbers of boxes, which are sometimes
> > down.  The timeout for figuring out the box is down is over an hour.  This is
> > just insane.
> >
> > Telnet and ftp behave similarly, or at least tthey lasted the 5 minutes I was
> > willing to wait, anyway.  Basically anything that calls connect().  If the
> > box doesn't respond in 15 seconds, I want to give up.
> >
> > Is this a problem with the kernel or with glibc?  If it's the kernel, I'd
> > expect a /proc entry where I can set this, but I can't seem to find one.  Is
> > there one?  What would be involved in writing one?
> >
>
> You can tune things by setting the tcp-timeout probably..I don't
> know exactly where to set this..

/proc/sys/net/ipv4/tcp_fin_timeout

default is 60.


