Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUBTH7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUBTH7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:59:21 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:22693 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264321AbUBTH7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:59:20 -0500
Message-ID: <4035BE0F.3000302@pacbell.net>
Date: Thu, 19 Feb 2004 23:58:07 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org> <1077259375.20787.1141.camel@gaston> <20040220070012.GA8121@kroah.com>
In-Reply-To: <20040220070012.GA8121@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> As for how ARM deals with their devices on non-pci busses, I really do
> not know, I never looked into that.

One way is that initialization specific to a given board or machine
is called from its INIT_MACHINE callback.  That can define platform
devices (SOC, ASICs, discrete parts, etc) and initialize platform_data
to feed drivers the right hardware info (addressing, which GPIOs etc).

Then normal platform_bus binding magic can apply, so that a driver
named "fred" gets probed for devices named "fred".

- Dave


