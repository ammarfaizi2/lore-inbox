Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTJ3PUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTJ3PUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:20:47 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:3508 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262591AbTJ3PUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:20:45 -0500
Message-ID: <3FA12A2E.4090308@pacbell.net>
Date: Thu, 30 Oct 2003 07:11:42 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com> <200310280300.h9S30Hkw003073@napali.hpl.hp.com>
In-Reply-To: <200310280300.h9S30Hkw003073@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> On x86, there is no OOps, it just freezes.  On ia64, I get a nice MCA
> and from that we can infer that a USB host controller read from
> address 0xf0000000 caused the problem but since this is asynchronous
> to the kernel's code path, the instruction pointer etc. in the MCA
> state dump isn't terribly helpful. 

Does that 0xf0000000 (on ia64) match any obvious address mapping
of the null pointer -- like a dma mapping?  I'm not sure that if
the HID driver were to pass a null buffer pointer, it would be
caught anywhere.

- Dave



