Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264599AbTI2TiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTI2TiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:38:16 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:1213 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264599AbTI2TiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:38:15 -0400
Message-ID: <3F788B25.8080002@pacbell.net>
Date: Mon, 29 Sep 2003 12:42:29 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Hong Feng <hongfeng@mgdigital.com.sg>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Sync problem with Ethernet-over-USB driver
 and Qtopia desktop
References: <20030917214836.A26822@infomag.infomag.iguana.be> <20030929123949.A19506@infomag.infomag.iguana.be> <6.0.0.22.0.20030929191802.025352f8@mail.mgdigital.com.sg>
In-Reply-To: <6.0.0.22.0.20030929191802.025352f8@mail.mgdigital.com.sg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hong Feng wrote:
> Hi All,
> 
> I met a very funny problem. I am writing the ethernet-over-usb driver 
> for our PDA based on embedded Linux and QT/Qtopia. ...
> 
> Who knows the problem, please give me some comments. BTW, the kernel 
> version is 2.4.18. QT's version is 2.3.6. Qtopia's version is 1.6.2.

And on what sort of hardware?

If you're writing your own ethernet-over-usb driver, perhaps the
problem is somewhere in that stack.  Either that ethernet driver,
or the one for your USB device controller could have the bugs.

The ethernet-over-usb driver in the "gadget" stack should behave
quite nicely.  It's the only network link on two systems I've
got running right now:  a net2280 on an NForce2 box (where 2.6
of course doesn't support the built-in ethernet); and a pxa255
(for nfsroot, MTD has acted broken on that hardware).  Neither
one has shown me the kind of un-usability problems you describe,
using either 2.4 or 2.6 kernels.  The network "just works", as
it should.  On the other hand, I'm not using Qtopia ... ;)

See http://www.linux-usb.org/gadget/ for more information about
that stack, and the 2.6 kerneldoc for printable API reference.

- Dave






