Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261546AbTCYGy6>; Tue, 25 Mar 2003 01:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbTCYGy6>; Tue, 25 Mar 2003 01:54:58 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:8851 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261546AbTCYGy5>;
	Tue, 25 Mar 2003 01:54:57 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Tue, 25 Mar 2003 08:06:05 +0100
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDE SiI680] throughput drop to 1/4
Message-ID: <20030325070605.GA26860@pc11.op.pod.cz>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030324072910.GA16596@pc11.op.pod.cz> <Pine.LNX.4.10.10303240943070.8000-100000@master.linux-ide.org> <20030324072910.GA16596@pc11.op.pod.cz> <200303241213.h2OCD6u21467@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10303240943070.8000-100000@master.linux-ide.org> <200303241213.h2OCD6u21467@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 07:13:06AM -0500, Alan Cox wrote:
> >   Recently I tried to figure out in 2.5.65, why throughput on my disk which
> > hangs on Silicon Image 680 dropped to 1/4 compared to 2.4.21-pre5, but didn't
> > found anything useful. Are there any known issues with this driver?
> 
> The same code in both cases. Its quite likely the problem is higher up in
> the block or filesystem layer. It might also be a general IDE layer bug
> 
> What does performance look like on your other disk between
> 2.4.21pre/2.5.65 ?

  Will test it as I come back home (it's on my home machine). But I think this
performance drop is only on the SiI680 interface.

On Mon, Mar 24, 2003 at 09:44:38AM -0800, Andre Hedrick wrote:
> There should be a mode or a flag option in the siimage.h to disable MMIO
> by default.  I am courious if this is a BARRIER on the read/write screwing
> the pooch!

  Back in late 2.5.4x (or was it early 2.5.5x ?) I tried
#undef CONFIG_TRY_MMIO_SIIMAGE but nothing has changed (now there's no such
symbol defined in siimage.c - gone in 2.5.63).

	Cheers,
		Vita
