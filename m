Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUH3QeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUH3QeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUH3QeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:34:22 -0400
Received: from wasp.net.au ([203.190.192.17]:3272 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268165AbUH3QeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:34:11 -0400
Message-ID: <41335723.40907@wasp.net.au>
Date: Mon, 30 Aug 2004 20:34:43 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au> <413350A2.1000003@pobox.com>
In-Reply-To: <413350A2.1000003@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm still pondering what Alan was hinting at, a bit.  You (Brad) are 
> correct in pointing out that this code should only trigger for the 
> correct situations (lba48, etc.) which are only present on modern 
> drives, but...  there is still a chance that word 93 will be zero on 
> some weird (probably non-compliant) device.

I agree completely, though my feeling is that if someone plugs a device that broken into a SATA 
controller via a bridge then there "aint nuffin we can do about it" anyway and if it breaks it 
breaks. I guess we could offer the option you suggested before where we load the individual drivers 
as modules and provide a "knobble" module parm that will limit max_sectors to 200 and udma_mask to 
udma/100.
Then we get the hassle if someone wants to use it as the root device, but I guess then you move to 
an initrd and load the module from there.

How far do we want to take it?

Regards,
Brad

