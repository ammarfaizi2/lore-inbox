Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbTA3QvK>; Thu, 30 Jan 2003 11:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTA3QvK>; Thu, 30 Jan 2003 11:51:10 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:47110 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267554AbTA3QvJ>; Thu, 30 Jan 2003 11:51:09 -0500
Date: Thu, 30 Jan 2003 19:59:44 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: pci_set_mwi() ... why isn't it used more?
Message-ID: <20030130195944.A4966@jurassic.park.msu.ru>
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org> <3E2C4FFA.1050603@pacbell.net> <20030130135215.GF6028@krispykreme> <3E3951E3.7060806@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E3951E3.7060806@pacbell.net>; from david-b@pacbell.net on Thu, Jan 30, 2003 at 08:25:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 08:25:07AM -0800, David Brownell wrote:
> At least on 2.5.59, the pci_generic_prep_mwi() code doesn't check
> for that type of error:  it just writes the cacheline size, and
> doesn't verify that setting it worked as expected.  Checking for
> that kind of problem would make it safer to call pci_set_mwi() in
> such cases ... e.g. using it on a P4 with 128 byte L1 cachelines
> would fail cleanly, while on an Athlon (64 byte L1) it might work
> (depending in which top bits are unusable).

Hmm, what happens if you boot the kernel configured for 80386
on P4 and enable MWI?

Ivan.
