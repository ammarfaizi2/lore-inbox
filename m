Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290917AbSAaEsn>; Wed, 30 Jan 2002 23:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290916AbSAaEsd>; Wed, 30 Jan 2002 23:48:33 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:38893 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S290917AbSAaEsW>; Wed, 30 Jan 2002 23:48:22 -0500
Date: Wed, 30 Jan 2002 23:48:21 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Implementing [options] field in a transport protocol's header.
Message-ID: <Pine.NEB.4.33.0201302344020.10460-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.4.17 kernel.
I am having troubles understanding how to implement 'options' field
(of possibly variable length) in my transport protocol's header.
For the fixed-size fields I just extend the structure describing
my packet's header (say, struct udphdr) and it works fine.

I know I'll need a function similar to net/ipv4/tcp_input.c :
tcp_parse_options. I believe I'll have to do the parsing of 'skb->data' in
my receiving function, but how do I (if at all) decribe those options
in include/linux/skbuff.h : skbuff structure? I mean, tcp, for instance,
doesn't have any options defined in struct tcphdr, but the options
_are_the part of a packet's header (and tcphdr is actually used to get a
pointer to them later on)...

Which part of the code actually separate the options (which
apparently are not defined in the structure describing the header) from
the user's data, and also at which point should I inject my options when
sending a packet (in such a way so I don't overwrite user's data)?
I use UDP implementation as my base, so please refer to it, if possible.

I'll appreciate any help.

-marek


