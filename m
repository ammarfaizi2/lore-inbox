Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDPRKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDPRKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDPRKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 13:10:18 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52950 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750759AbWDPRKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 13:10:18 -0400
Date: Sun, 16 Apr 2006 21:09:47 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060416170947.GA9202@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com> <20060415111443.GA4079@2ka.mipt.ru> <87hd4vvxpk.fsf@briny.internal.ondioline.org> <20060415123832.GA19850@2ka.mipt.ru> <369a7ef40604150624n28da8895if158a2c13cac2b9e@mail.gmail.com> <20060416075323.GB6101@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060416075323.GB6101@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 16 Apr 2006 21:09:51 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2006 at 11:53:23AM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Sat, Apr 15, 2006 at 03:24:26PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> > OK, so what would you suggest as the right "tool" to transfer these
> > (full path text) information?
> > 
> > I see these options:
> > 1, Keep using procfs (I don't like it)
> > 2, Use connector and create such "communication protocol" that it'll
> > be able to transfer such long messages in more datagrams (even if
> > 99.99% of messages will fit 1 datagram)
> > 3, Some other API to transfer information to user-space and back?
> > 
> > I'll probably go with 2, but I'd be more then happy to hear any
> > comments about this...

Btw, I forgot to say, that CONNECTOR_MAX_MSG_SIZE restriction to maximum
allowed message size is only applicable for userspace->kernelspace
direction. Messages, emmited by kernel, can have any size you want.

-- 
	Evgeniy Polyakov
