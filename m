Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWGYF5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWGYF5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWGYF5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:57:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56529 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751071AbWGYF5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:57:13 -0400
Message-ID: <44C5B2B4.4090300@pobox.com>
Date: Tue, 25 Jul 2006 01:57:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2 Intermittent failures to detect sata disks
References: <9235.1153806649@kao2.melbourne.sgi.com>
In-Reply-To: <9235.1153806649@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Keith Owens (on Fri, 21 Jul 2006 16:18:47 +1000) wrote:
>> I am seeing an intermittent failures to detect sata disks on
>> 2.6.18-rc2.  Dell SC1425, PIIX chipset, gcc 4.1.0 (opensuse 10.1).
>> Sometimes it will detect both disks, sometimes only one, sometimes none
>> at all.  AFAICT it only occurs after a soft reboot, and possibly only
>> after an emergency reboot.  Alas the problem is so intermittent that it
>> is hard to tell what conditions will trigger it.
> 
> I applied the debug patch below, turn on prink timing and set
> initdefault to 6 so the machine was in a continual soft reboot cycle.
> After multiple cycles I got this trace.  piix_sata_prereset() reads a
> zero config byte for almost 15 seconds then it changes to 0x11,
> followed by a hang.  Why is the config byte initially zero, and what
> makes it change?  The normal value for pcs is 0x33.

Can you try 2.6.18-rc2-git3?

	Jeff



