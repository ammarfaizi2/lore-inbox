Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJBBDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTJBBDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:03:16 -0400
Received: from main.gmane.org ([80.91.224.249]:42667 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262709AbTJBBDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:03:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [ACPI] p2b-ds blacklisted?
Date: Thu, 02 Oct 2003 03:02:15 +0200
Message-ID: <blftgg$9ui$1@sea.gmane.org>
References: <blen4v$a42$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: de, en
In-Reply-To: <blen4v$a42$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to try what happens if i remove the board from the 
> blacklist.

So that was what i just did. I removed the board from the blacklist, 
recompiled the kernel and booted.
The kernel started and there were some issues with the interrupt 
routing. I don't remember the exact messages but i could post a dmesg if 
you like.
With "pci=noapci" the computer hang upon loading the kernel module for 
the SCSI controller. I remember that to be an issue too when i had 
windows2k installed on that box but i could "fix" that by changing the 
IRC setting in the BIOS. Changing those settings didn't help Linux to boot.

At first sight ACPI (without pci=noacpi) seemed to work but pressing the 
power button didn't generate any events although the power button was 
detected properly during boot.

After all i think i know why P2B-S and -DS are blacklisted. The board 
with on-board SCSI controller are messed up somehow.

I haven't tried to install BIOS 1014beta3 yet. BIOS 1014beta2 is 
currently installed but i guess the update won't solve anything.

With acpi=ht it works for now, but doesn't acpi=ht imply pci=noacpi?


