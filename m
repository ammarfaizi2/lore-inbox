Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbTLRPaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbTLRPaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:30:05 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:9606 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265210AbTLRPaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:30:01 -0500
Message-ID: <3FE1C973.2070600@pacbell.net>
Date: Thu, 18 Dec 2003 07:36:19 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Richard Curnow <Richard.Curnow@superh.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Handling of bounce buffers by rh_call_control
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net> <20031218143236.GB20057@malvern.uk.w2k.superh.com>
In-Reply-To: <20031218143236.GB20057@malvern.uk.w2k.superh.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Curnow wrote:
> 
> IIRC, if I plug a USB2 device into a USB2 card but don't have the EHCI
> driver active, the device is just ignored, rather than falling back to
> using USB1.1 through OHCI?  We certainly have some USB2 devices we'd
> like to use, even if the USB2 bandwidth might be throttled back by the
> bounce buffering overhead.

Yes, high speed USB transfers need the EHCI driver.
If that driver isn't running, then OHCI (or UHCI)
should kick in.  (Assuming that driver is running!)

Most high speed storage seems to work with the current
EHCI code, although some hardware acts unhappy when
Linux talks to it faster than Windows does.  That's
more of an issue on 2.6 than on 2.4 though.

- Dave



