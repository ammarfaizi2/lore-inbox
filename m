Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSEMIjg>; Mon, 13 May 2002 04:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSEMIjf>; Mon, 13 May 2002 04:39:35 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:6281 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S293680AbSEMIje>; Mon, 13 May 2002 04:39:34 -0400
Date: Mon, 13 May 2002 10:39:21 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Narancs v1 <narancs@narancs.tii.matav.hu>, linux-kernel@vger.kernel.org
Subject: Re: net/ipv4/conf/* config order
In-Reply-To: <3CDF6CE0.4080604@drugphish.ch>
Message-ID: <Pine.GSO.4.05.10205131034570.7358-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip

> > sysctl -a|grep source
> > net/ipv4/conf/eth2/accept_source_route = 1
> > net/ipv4/conf/eth1/accept_source_route = 1
> > net/ipv4/conf/eth0/accept_source_route = 1
> > net/ipv4/conf/lo/accept_source_route = 1
> > net/ipv4/conf/default/accept_source_route = 1
> > net/ipv4/conf/all/accept_source_route = 0
> 
> Basically, accept_source_route says how to handle packets with the SRR 
> option set. If 1 (default for a router) it accepts those packets, if 0 
> (default for a host) it will drop them. [This is actually written in 
> ../Documentation/networking/ip-sysctl.txt]

--snip/snip
> ps.: I don't think this question belongs to lkml, next time you should
>       maybe choose linux-net@vger.kernel.org.

beside your explanation, IMHO this belongs to the ML, since the
implementation generates confusion for the user.

wouldn't it be better to implement something like

/all/* = -1	means i don't have set this for all

and if i set something for /all/* this should be reflected in the individual
entries as well?

	just my $0.02

		tm

-- 
in some way i do, and in some way i don't.

