Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286129AbRLJBCp>; Sun, 9 Dec 2001 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286128AbRLJBCf>; Sun, 9 Dec 2001 20:02:35 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:25596 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S286127AbRLJBCR>;
	Sun, 9 Dec 2001 20:02:17 -0500
Date: Sun, 9 Dec 2001 19:58:40 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
In-Reply-To: <20011209231340.A23420@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112091956500.6079-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, bert hubert wrote:

> On Sun, Dec 09, 2001 at 05:07:03PM -0500, jamal wrote:
> > > > So priority limits the size of skb->priority to be from 0..6; this wont
> > > > work with that check in cbq.
> > >
> > > No, only IP_TOS does so.
> >
> > probaly ip precedence. Have you tried this or you are following what the
> > man pages say?
>
> I have been living in the source for quite a while now - see ip_setsockopt()
> in net/ipv4/ip_sockglue.c.
>

Thats the wrong place to look. Look instead at:
net/core/sock.c
I got it; non root is limited to 0..6; root can set the full 32 bit range.

cheers,
jamal

