Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUBTIop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUBTIop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:44:45 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:46280 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S267740AbUBTIoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:44:44 -0500
Message-ID: <4035C8C4.8010605@pacbell.net>
Date: Fri, 20 Feb 2004 00:43:48 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <20040220074041.GA6680@plexity.net> <1077263253.20789.1221.camel@gaston> <20040220080801.GA6786@plexity.net>
In-Reply-To: <20040220080801.GA6786@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> On Feb 20 2004, at 18:47, Benjamin Herrenschmidt was caught saying:
> 
>>>If you mean the USB target device itself, can't you walk the
>>>tree until you find a device that is no longer on bus_type
>>>usb to determine your root?
>>
>>I don't feel like walking the tree on each pci_dma access

Why should that be needed though?


> I never said it would be pretty. :)

Well, usb_device->bus->controller is the only access that
should be needed ... much prettier than a tree walk!  It's
set up as part of device enumeration.

Some of the usb_buffer_*() mapping calls could probably
start to get inlined now, using the generic DMA calls.

- Dave

