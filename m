Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTKFOLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTKFOLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:11:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:29386 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263646AbTKFOLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:11:04 -0500
Date: Thu, 6 Nov 2003 12:06:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Beau E. Cox" <beau@beaucox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.23-pre7,pre8,pre9 hang on starting squid
In-Reply-To: <200311030708.09283.beau@beaucox.com>
Message-ID: <Pine.LNX.4.44.0311061204510.8534-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Nov 2003, Beau E. Cox wrote:

> [1.] summary:
> 
> 2.4.23-pre7,pre8,pre9 hang depending on when 'squid' is started.
> 
> [2.] Full description:
> 
> Running up-to-date Sorcerer.
> 
> One machine hangs consistently when this sequence of daemons
> is started in runlevel 3:
> 
>    S26networking       ifconfig etho, eth1, eth1:1 & routes
>    S28firewall         firewall viaiptables
>    S30portmap          5beta
>    S32ntpd             4.2.0
>    S34named            bind 9.2.3
>    S36nfs
>    S38rpc.bootparamd
>    S40xinetd
>    S42squid            2.5.STABLE4
>    S44mysql            4.0.15a
>    S46xmail            xmailserver mail server 1.17
>    S48spamd
>    S50apachectl        2.0.48
> 
> It works flawlessly when squid is put to the bottom:
> 
>    S26networking
>    S28firewall
>    S30portmap
>    S32ntpd
>    S34named
>    S36nfs
>    S38rpc.bootparamd
>    S40xinetd
>    S42mysql
>    S44xmail
>    S46spamd
>    S48apachectl
>    S50squid
> 
> Why am I bothering you kernel folks with what looks like a pure
> SA problem?
> 
>    1. This machine works flawlessly (with squid started before
>       mysql, etc.) unter 2.4.22.
>    2. Four other machines running the same software (I compile
>       my own packages via Sorcerer) using 2.4.23-pre9 and squid
>       above.
>    3. This problem is solid on this one machine. Always reproduceable.
>       Always hangs with squid. No dumps found. Just HANG.

Strange. 

Can you find out in which -pre the problem starts?

