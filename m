Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUC1PfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 10:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUC1PfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 10:35:25 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:44216 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261843AbUC1PfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 10:35:18 -0500
Message-ID: <4066F082.6080804@pacbell.net>
Date: Sun, 28 Mar 2004 07:34:26 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: don <don_reid@comcast.net>
CC: David Woodhouse <dwmw2@infradead.org>,
       Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <40636295.7000008@pacbell.net> <1080297466.29835.144.camel@hades.cambridge.redhat.com> <40644FCA.8000206@pacbell.net> <20040326232328.GA29771@reid.corvallis.or.us> <4065B39A.2040003@pacbell.net> <20040328024712.GA30855@reid.corvallis.or.us>
In-Reply-To: <20040328024712.GA30855@reid.corvallis.or.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don wrote:

>>>A host driver "USB PTP Storage" would be really nice too.  First
>>>as a generic camera interface, second to access a gadget with the
>>>PTP interface.
>>
>>There isn't one.  There are two.  No need to be embarrassed ... ;)
>>
>>They're both user-mode drivers.  "gPhoto2", and "jPhoto".  The
>>author of jPhoto (moi) hasn't had time to update that code in
>>ages.
> 
> 
> These are applications, not file system interfaces like USB Mass Storage.
> I want to mount the camera or gadget file system and access it from any
> program, not run a separate app to fetch files like Mass Stor. mounts
> a memory device.

As Andrew Zabolotny commented, NFS _does_ work today from those
devices.  Except that it doesn't work to MS-Windows hosts, unless
they've been taught other parts of the protocol stack.

Presumably Samba over RNDIS would work from Windows, but that
would need extra work from many Linux hosts.  Tradeoffs...


> Why create a dedicated app like a camera interface instead of using your
> favorite image browser on some files?

Well, PTP should take less memory inside the device/gadget than
a network stack, though it'd be less flexible.  And there's
also something to be said for less code in the kernel, and a
simpler device setup model ... especially for the kinds of
products that'd be considering something like PTP.

But I think the basic answer to your question is probably just
that nobody's yet written, or at least submitted, PTP client
or server kernel code for Linux.

- Dave

