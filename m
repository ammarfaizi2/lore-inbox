Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUJJBfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUJJBfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUJJBfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:35:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6588 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268024AbUJJBfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:35:06 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097286154.5592.9.camel@gaston>
References: <1097179099.1519.17.camel@deimos.microgate.com>
	 <1097177830.31768.129.camel@localhost.localdomain>
	 <20041008062650.GC2745@thunk.org>
	 <1097242506.2008.30.camel@deimos.microgate.com>
	 <1097239894.2290.13.camel@localhost.localdomain>
	 <20041008150055.GA13870@thunk.org>  <1097286154.5592.9.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097368333.6128.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 10 Oct 2004 01:32:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-09 at 02:42, Benjamin Herrenschmidt wrote:
> That reminds me... a while ago, I toyed with the idea of having DMA
> support in pmac_zilog. The case where it would work well is typically
> for things that have a known sized frame. If that information was
> provided down to the driver, I could setup the DMA descriptor for
> that frame size & have it interrupt me when the frame is complete,
> along with a timeout set to the estimated time for receiving such
> a frame + X% (I was thinking +20%)

I thought the 85C30 only supported DMA for sync modes ? We have sync
8530 DMA code for ISA bus already, which I never got around to adding
async too 8)

