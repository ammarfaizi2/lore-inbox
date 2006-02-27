Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWB0Ww2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWB0Ww2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWB0Ww2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:52:28 -0500
Received: from mail.dvmed.net ([216.237.124.58]:22749 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932107AbWB0Ww1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:52:27 -0500
Message-ID: <4403829C.2070706@pobox.com>
Date: Mon, 27 Feb 2006 17:52:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
References: <44028502.4000108@soft.fujitsu.com> <20060227214244.GA9008@colo.lackof.org> <44037BC6.30003@pobox.com> <200602272342.11047.ak@suse.de>
In-Reply-To: <200602272342.11047.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 27 February 2006 23:23, Jeff Garzik wrote:
> 
>>Or do you have another way of avoiding unused resource allocation?
>>
>>Fix the [firmware | device load order] to allocate I/O ports first to 
>>the hardware that only supports IO port accesses. 
> 
> 
> How should the firmware know what hardware needs io ports and what hardware
> doesn't? I don't think it will scale well to put long lists of PCI-IDs into 
> their firmware.

Its trivial to detect PCI hardware that doesn't support MMIO, the 
"IO-only" hardware Grant mentioned...

	Jeff



