Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVJQSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVJQSCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVJQSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:02:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8685 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932078AbVJQSCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:02:01 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
Date: Mon, 17 Oct 2005 20:02:23 +0200
User-Agent: KMail/1.8
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, nyk <nyk@giantx.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
References: <20051017144900.GA2942@giantx.co.uk> <200510171841.39868.ak@suse.de> <1129572062.2424.3.camel@localhost>
In-Reply-To: <1129572062.2424.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172002.24210.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 20:01, Alan Cox wrote:
> On Llu, 2005-10-17 at 18:41 +0200, Andi Kleen wrote:
> > IMHO the right fix is to put that atomic scrub thingy into another
> > include file. It seems to cause major additional include dependencies and
> > is only used in a single file right now.
>
> Every file I looked at (I've not looked at NTFS) included types.h if it
> included atomic.h but sometimes directly or indirectly after atomic.h
> rather than before.
>
> I was thinking of just writing a tool to find the other cases and then
> fix those I can.

I think it is far better you do it in a different macro in a different file
without any nasty dependencies. What you're trying to do has nothing
to do with atomic_t anyways. It is just abuse of atomic.h

-Andi

