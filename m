Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbTGOTZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbTGOTZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:25:30 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:34742 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S269617AbTGOTZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:25:24 -0400
Message-ID: <3F14590E.90202@pacbell.net>
Date: Tue, 15 Jul 2003 12:42:06 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Problems with usb-ohci on 2.4.22-preX
References: <20030712141431.GA3240@puettmann.net> <200307151547.22615.roger.larsson@skelleftea.mail.telia.com> <3F14491B.6020809@pacbell.net> <20030715192241.GA4862@kroah.com>
In-Reply-To: <20030715192241.GA4862@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jul 15, 2003 at 11:34:03AM -0700, David Brownell wrote:
> 
>>I've hardly ever seen ACPI do anything except break USB.
> 
> 
> Heh, my laptop _requires_ ACPI to get USB to work properly :)

The fact that I've seen one laptop work with ACPI is the
entire reason I said "hardly ever" ... ;)   I've seen some
hardware work with "pci=noacpi", which still counts as
broken in my book.

Desktop hardware has uniformly broken if I enable ACPI in
the build.  The usual rule of thumb seems to be that when
ACPI assigns the USB IRQs to values over 16, they won't
work for me ... example, 2.5.75 on an SN41G2 assigned
all four USB controllers (including a net2280!) that way.

That was a curious symptom though:  /proc/interrupts
showed endless streams of IRQs going to the devices,
rather than the somewhat-more-typical "no IRQs".  I had
not seen that before.  (It was almost a 2.6-test1 kernel.)

In theory, this is just a bug that will get fixed, but
in practice, the behavior has never yet changed.

- dave


