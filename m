Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTFCOTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbTFCOTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:19:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:48774 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265021AbTFCOTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:19:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 3 Jun 2003 07:30:26 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [patch] SiS IRQ router 96x detection ...
In-Reply-To: <1054644033.9234.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0306030726150.4125@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306022301210.3577@bigblue.dev.mcafeelabs.com>
 <1054644033.9234.6.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Alan Cox wrote:

> On Maw, 2003-06-03 at 07:06, Davide Libenzi wrote:
> > Thanks to Thomas we now know how to detect the 96x SiS SB. The patch
> > against 2.4.20 uses the documentated method to use the correct router
> > function and hence make new SiS chipsets to work with the new USB routing
> > registers. Tested and working fine on my machine.
>
> > +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set, NULL },
> > +	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set, NULL },
>
> The NULL is implied so you don't need to mash every entry in the table..

I know is implied Alan, but you either use the std ".field = xxx" or you
fill out members. Otherwise the next one eventually extending the table
might find himself screwed. Or you use a macro to initialize each member.


- Davide

