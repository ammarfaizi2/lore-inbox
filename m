Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbRHGPKJ>; Tue, 7 Aug 2001 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRHGPKA>; Tue, 7 Aug 2001 11:10:00 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:54918 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S268129AbRHGPJx>;
	Tue, 7 Aug 2001 11:09:53 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew McNamara <andrewm@connect.com.au>, linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ?
In-Reply-To: <20010726070621.D69A1BE91@wawura.off.connect.com.au> <20010726193934.A29055@weta.f00f.org>
From: Jes Sorensen <jes@sunsite.dk>
Date: 07 Aug 2001 17:09:47 +0200
In-Reply-To: Chris Wedgwood's message of "Thu, 26 Jul 2001 19:39:34 +1200"
Message-ID: <d33d73x5xg.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Wedgwood <cw@f00f.org> writes:

Chris> On Thu, Jul 26, 2001 at 05:06:21PM +1000, Andrew McNamara
> wrote: Does this mean the ISRs for every driver sharing an
> interrupt have to poll their device when an interrupt comes in
> (in the case of shared PCI interrupts), or is there some
> additional hardware smarts so the kernel knows which driver's
> ISRs need to be invoked?

Chris> Yes, drivers need to check their hardware devices and
Chris> acknowledge whether or not it's was their interrupt or not.  It
Chris> sounds terrible but even with many thousands of interrupts per
Chris> second the cost doesn't seem to be that high.

Not only is this the case, it's also the only sane thing to do <tm>,
any device driver should check the status of the hardware it is
serving before doing anything else.

Jes
