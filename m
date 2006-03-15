Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWCOWrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWCOWrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWCOWrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:47:20 -0500
Received: from mail.dvmed.net ([216.237.124.58]:34955 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751656AbWCOWrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:47:19 -0500
Message-ID: <4418996E.6010808@garzik.org>
Date: Wed, 15 Mar 2006 17:47:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Warning - Maxtor SATA II and Nvidia nforce4
References: <1142461887.2521.44.camel@station14.example.com>
In-Reply-To: <1142461887.2521.44.camel@station14.example.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ah, I see this made it to LKML :)

Dax Kelson wrote:
> Short version
> ==============
> Nvidia Nforce4 chipset with Maxtor SATA II drives with certain firmware
> revisions cause data corruption and system instability when under
> moderate to heavy I/O load.

I'm a bit suspicious of this.

Looking at the link, there are three problem areas and two problem blame 
targets implied:

	Data corruption	-> blame nvidia driver
	NCQ		-> blame nvidia driver
	Detection	-> blame maxtor firmware

The first one likely applies to the Windows driver not Linux's sata_nv, 
and thus irrelevant here.  The second one OBVIOUSLY applies only to 
Windows, since sata_nv (and libata itself) don't yet enable NCQ.  The 
third one could potentially apply to Linux.  Lastly, your mention of 
"nforce fake raid" almost certainly indicates Windows or proprietary 
drivers.

Therefore, I ask:
* are you reporting a only drive detection problem?
* why are you reporting unrelated Windows problems to a Linux list?
* if you are indeed reporting a problem on Linux, where is the kernel 
and driver version info, as requested in REPORTING-BUGS?
* and can you provide such info *and reproduce the problems* without 
proprietary drivers loaded?

Your email is just a list of highly general symptoms.  Your link seems 
to indicate two NV driver bugs on Windows, and a Maxtor firmware upgrade 
for undescribed detection problems.

My recommended action for users is:
1) Avoid Windows.
2) Don't panic.

	Jeff


