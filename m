Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTKFRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTKFRu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:50:27 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:23438 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S263788AbTKFRuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:50:19 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: PROBLEM: 2.4.23-pre7,pre8,pre9 hang on starting squid
Date: Thu, 6 Nov 2003 07:49:25 -1000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311061204510.8534-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0311061204510.8534-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311060749.25212.beau@beaucox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 04:06 am, Marcelo Tosatti wrote:
> On Mon, 3 Nov 2003, Beau E. Cox wrote:
> > [1.] summary:
> >
> > 2.4.23-pre7,pre8,pre9 hang depending on when 'squid' is started.
> >
> > [2.] Full description:
> >
> > Running up-to-date Sorcerer.
> >
> > One machine hangs consistently when this sequence of daemons
> > is started in runlevel 3:
> >
> >    S26networking       ifconfig etho, eth1, eth1:1 & routes
> >    S28firewall         firewall viaiptables
> >    S30portmap          5beta
> >    S32ntpd             4.2.0
> >    S34named            bind 9.2.3
> >    S36nfs
> >    S38rpc.bootparamd
> >    S40xinetd
> >    S42squid            2.5.STABLE4
> >    S44mysql            4.0.15a
> >    S46xmail            xmailserver mail server 1.17
> >    S48spamd
> >    S50apachectl        2.0.48
> >
> > It works flawlessly when squid is put to the bottom:
> >
> >    S26networking
> >    S28firewall
> >    S30portmap
> >    S32ntpd
> >    S34named
> >    S36nfs
> >    S38rpc.bootparamd
> >    S40xinetd
> >    S42mysql
> >    S44xmail
> >    S46spamd
> >    S48apachectl
> >    S50squid
> >
> > Why am I bothering you kernel folks with what looks like a pure
> > SA problem?
> >
> >    1. This machine works flawlessly (with squid started before
> >       mysql, etc.) unter 2.4.22.
> >    2. Four other machines running the same software (I compile
> >       my own packages via Sorcerer) using 2.4.23-pre9 and squid
> >       above.
> >    3. This problem is solid on this one machine. Always reproduceable.
> >       Always hangs with squid. No dumps found. Just HANG.
>
> Strange.
>
> Can you find out in which -pre the problem starts?

Hi - yep, very strange. I will try to find when it starts and any other
goodies I can dig up. Thanks for the reply - I hope it's not me
doing something really stupid and wasting your time...:)

Aloha => Beau;

