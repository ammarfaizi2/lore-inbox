Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVGTTp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVGTTp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 15:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVGTTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 15:45:27 -0400
Received: from mail.dvmed.net ([216.237.124.58]:6282 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261496AbVGTTpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 15:45:25 -0400
Message-ID: <42DEA9C8.2030101@pobox.com>
Date: Wed, 20 Jul 2005 15:45:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lewis <dlewis@vnxsolutions.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE PIIX vs libata piix with software raid
References: <200507201926.j6KJQW6L021545@mail.jettisonnetworks.com>
In-Reply-To: <200507201926.j6KJQW6L021545@mail.jettisonnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lewis wrote:
> Greetings,
> 
> I am developing a system using the Intel SE7520BD2 motherboard. It has an
> ICH5 with two SATA ports and one PATA channel. I am able to drive the PATA
> channel with either the normal PIIX IDE driver or the libata driver which I
> am using for the SATA ports. Ultimately all 4 ports will be in use with the
> md driver creating a stripe volume (RAID0) that spans a partition on each of
> the 4 drives (not for boot).
> 
> My question is, what is the recommended driver to use for the PATA channel?
> Is it better to let libata support both types of drives, or use the IDE
> driver for the PATA? Searching I have found that the support is there in
> libata for the PATA channel (and I have it working on the system), but I
> can't find a clear recommendation on which driver is considered 'better' in
> this situation.

If you're just using hard drives, there should be no problem using 
libata for both PATA and SATA.

However, in general, the IDE driver (CONFIG_IDE) is recommended for PATA.

	Jeff



