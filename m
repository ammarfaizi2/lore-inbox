Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUJOUMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUJOUMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUJOUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:12:20 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:50348 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S268409AbUJOUMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:12:14 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: a.ledvinka@promon.cz
Subject: Re: promise (105a:3319) unattended boot
Date: Fri, 15 Oct 2004 21:12:18 +0100
User-Agent: KMail/1.7
References: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
In-Reply-To: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410152112.18691.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 Oct 2004 15:41, you wrote:
> Hello.
>
> Got here http://pciids.sourceforge.net/iii/?i=105a3319
> As http://linux.yyz.us/sata/faq-sata-raid.html#tx4 calls it
> soft/accelerator raid version
> Going to use latest kernel from /pub/linux/kernel/v2.4/
>
> But bios even with keyboard unplugged requires me to press one of 2 keys
> to either define array OR continue booting in case no array is defined.
>
> What would you recommend me to do?
> - stay with ft3xx module from promise  and 10 level RAID array and not use
> sata_promise?
> - define some array in bios and completely ignore that fact and use
> sata_promise, bypass bios and define custom linux soft raid arrays?

If you define an array, AFAIK the controller doesn't do anything physically to 
the discs. It's just the settings it tells the promise driver (thus software 
RAID). If you define ANY array, the drives should still be detected by Linux 
individually and you can use linux/md to RAID them.

This is how I'm doing it on my older PATA promise card.

> - anything else (no bios flashing and no hw hacking)?
>

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
