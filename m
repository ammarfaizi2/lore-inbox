Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVJQSBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVJQSBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJQSBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:01:03 -0400
Received: from 217-195-233-66.dsl.esined.net ([217.195.233.66]:9617 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751314AbVJQSBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:01:00 -0400
Subject: Re: [patch] Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, nyk <nyk@giantx.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200510171841.39868.ak@suse.de>
References: <20051017144900.GA2942@giantx.co.uk>
	 <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
	 <200510171841.39868.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Oct 2005 19:01:02 +0100
Message-Id: <1129572062.2424.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-17 at 18:41 +0200, Andi Kleen wrote:
> IMHO the right fix is to put that atomic scrub thingy into another include
> file. It seems to cause major additional include dependencies and 
> is only used in a single file right now.

Every file I looked at (I've not looked at NTFS) included types.h if it
included atomic.h but sometimes directly or indirectly after atomic.h
rather than before.

I was thinking of just writing a tool to find the other cases and then
fix those I can.

