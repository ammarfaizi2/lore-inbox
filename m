Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVCUJoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVCUJoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCUJoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:44:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:16125 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261715AbVCUJoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:44:24 -0500
Message-ID: <423E96F9.2010301@imag.fr>
Date: Mon, 21 Mar 2005 10:42:17 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050304
X-Accept-Language: en-us, en, fr-fr
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: Neil Whelchel <koyama@firstlight.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA Promise TX4 Crash
References: <Pine.LNX.4.44.0503201555580.12407-100000@kishna.firstlight.net> <423E70D7.8060707@wasp.net.au>
In-Reply-To: <423E70D7.8060707@wasp.net.au>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Mon, 21 Mar 2005 10:44:19 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Neil Whelchel wrote:
> 
>> Hello,
>> I have two Promise SATA TX4 cards connected to a total of 6 Maxtor 250 GB
>> drives (7Y250M0) configured into a RAID 5. All works well with small
>> disk load, but when a large number of requests are issued, it causes 
>> crash
>> similar to the attached, except that the errors before the crash are on a
> 
> 
>> EFLAGS: 00010046   (2.6.11.2)
>> EIP is at scsi_put_command+0xbb/0x100
> 
> 
> Oooh Oooh Oooh, pick me Mr Kotter!
> I have seen this repeatedly, fought it and "apparently" beat it by 
> upgrading my PSU.
> I could reliably reproduce it by running a raid resync and issuing SMART 
> queries
> to the drives, but after a PSU upgrade it has gone away.
> I have tried hard to reproduce it recently but I just can't get it to 
> crash anymore.
> 
> I have a similar setup 4x SATA-TX4 cards and 15x 7Y250M0 drives. I'm 
> thought it was actually
> a bug, but as I can't reproduce it anymore it's making it a bit hard to 
> track down.
> 
> Not much help, sorry.
> 
> Brad

I have similar crashes with a (netbooted) epia and 4 250G Seagate 7200.8 
PATA drives.
removing the kernel preempt stuff & realtime scheduling and stuff 
alleviates the issue a bit but it occured again yesterday.

a quirk in the epia forces me to reboot the box by power cycling it.
