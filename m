Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267664AbRGZHjc>; Thu, 26 Jul 2001 03:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbRGZHjX>; Thu, 26 Jul 2001 03:39:23 -0400
Received: from weta.f00f.org ([203.167.249.89]:36485 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267670AbRGZHjM>;
	Thu, 26 Jul 2001 03:39:12 -0400
Date: Thu, 26 Jul 2001 19:39:34 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrew McNamara <andrewm@connect.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to tell Linux *not* to share IRQs ?
Message-ID: <20010726193934.A29055@weta.f00f.org>
In-Reply-To: <20010726070621.D69A1BE91@wawura.off.connect.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010726070621.D69A1BE91@wawura.off.connect.com.au>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 05:06:21PM +1000, Andrew McNamara wrote:

    Does this mean the ISRs for every driver sharing an interrupt have
    to poll their device when an interrupt comes in (in the case of
    shared PCI interrupts), or is there some additional hardware
    smarts so the kernel knows which driver's ISRs need to be invoked?

Yes, drivers need to check their hardware devices and acknowledge
whether or not it's was their interrupt or not.  It sounds terrible
but even with many thousands of interrupts per second the cost doesn't
seem to be that high.




  --cw
