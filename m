Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUIKRaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUIKRaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUIKR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:27:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49843 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268232AbUIKR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:26:10 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040911101331a584ec@mail.gmail.com>
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911101331a584ec@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094919816.21082.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 17:23:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 18:13, Jon Smirl wrote:
> Coprocessor 3D mode is deeply pipelined
> 2D mode is immediate

Card dependant.

> How can you build a system that process swaps between these two modes?
> The 3D pipeline has to be emptied before you can enter 2D immediate
> mode.
> My solution is to leave the coprocessor always running and convert
> everything to use the DMA based commands.

On such a card when DRI is available that is probably the right path,
especially if it has the "can't software touch the frame buffer while
the engine runs" design flaw.

If DRI isn't loaded, or isn't running you can carry on unaccelerated.

