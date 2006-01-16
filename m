Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWAPUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWAPUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWAPUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:52:56 -0500
Received: from drugphish.ch ([69.55.226.176]:12520 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751183AbWAPUw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:52:56 -0500
Message-ID: <43CC079D.5060008@drugphish.ch>
Date: Mon, 16 Jan 2006 21:52:45 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Willy TARREAU <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
References: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch> <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch> <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch> <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu> <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu> <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu> <20060115224642.GA10069@w.ods.org> <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.64.0601151452460.5053@potato.cts.ucla.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The machine was /not/ booted into that config.  It is running the 
>>> original config from 
>>> http://hashbrown.cts.ucla.edu/pub/oops-200512/config-2.4.32 with 
>>> DEBUG_SLAB defined and "pci=noacpi" passed in on the command line.
>>>
>>> The config with HIGHIO disabled an ACPI=y has not been tested.

CONFIG_SMP at least sets CONFIG_ACPI_BOOT. Do you still have the boot 
messages somewhere (dmesg)? I'd be interested in the difference between 
IOAPIC PCI routing entries between pci=noacpi and normal boot.

>> Thanks for the precision. So logically we should expect it to break 
>> sooner or later ?
> 
> It is the same .config as one that crashed before, except that it has 
> DEBUG_SLAB defined.  If it does not crash, then adding pci=noacpi to the 
> command fixes the problem for me.

Hmm, I'm not fully convinced yet, however glad that it has been a bit 
more stable for you.

Sidenote: We boot our systems having built-in AIC7* SCSI on moderately 
cheap motherboards with "bad" interrupt routing using pci=noacpi on 
2.4.x kernels to evade instability.

I suggest that if you experience more problems using this setup _and_ 
would like to continue debugging the issue, we take this off-list into a 
private discussion.

[Another thing which would be interesting to test regarding the HIGHIO 
setting is a RedHat based 2.4.x kernel, since according to some SCSI 
driver's documentation, RedHat had a different HIGHIO convention.]

Thanks for your feedback,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
