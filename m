Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293225AbSCEBBY>; Mon, 4 Mar 2002 20:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293138AbSCEBBQ>; Mon, 4 Mar 2002 20:01:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39128 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293142AbSCEBBE>;
	Mon, 4 Mar 2002 20:01:04 -0500
Date: Mon, 4 Mar 2002 17:01:01 -0800
To: James Stevenson <mail-lists@stev.org>
Cc: jt@hpl.hp.com, paulus@samba.org, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020304170101.A32589@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com> <002701c1c3e0$7f5a27b0$0501a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002701c1c3e0$7f5a27b0$0501a8c0@Stev.org>; from mail-lists@stev.org on Tue, Mar 05, 2002 at 12:55:51AM -0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 12:55:51AM -0000, James Stevenson wrote:
> > Tx queue length
> > ---------------
> > Problem : IrDA does its buffering (IrTTP is a sliding window
> > protocol). PPP does its buffering (1 packet in ppp_generic +
> > dev->tx_queue_len = 3). End result : a large number of packets queued
> > for transmissions, which result in some network performance issues.
> >
> > Solution : could we allow the PPP channel to overwrite
> > dev->tx_queue_len ?
> > This is similar to the channel beeing able to set the MTUs and
> > other parameters...
> 
> somebody please correct me if i am wrong but if the
> txqueuelen not set from userspace from
> ifconfig ?

linux/drivers/net/ppp_generic.c, line 888, ppp_net_init()
------------------------
	dev->tx_queue_len = 3;
------------------------

	Jean
