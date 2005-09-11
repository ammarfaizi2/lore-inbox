Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVIKUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVIKUkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVIKUkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:40:32 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:15010 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750861AbVIKUkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:40:31 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, "Gaston, Jason D" <jason.d.gaston@intel.com>,
       mj@ucw.cz, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Mon, 12 Sep 2005 06:40:14 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <ec49i1l8pnftuo1fqsl5oejmc1qp00cin8@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com> <20050911031150.GA20536@kroah.com> <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com> <4323EFFE.2040102@pobox.com>
In-Reply-To: <4323EFFE.2040102@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 04:51:10 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

>Grant Coady wrote:
>> Just ran the discovery script on 2.6.13.mm2, there's roughly 1609 
>> symbols unused in pci_ids.h, another 1030 are defined throughout the 
>> source tree, leaving 729 in pci_ids.h.  Total unique symbols is 1030.
>> Not counted are macro defined symbols: 
>> 
>> PCI_DEVICE_ID_##id
>> PCI_DEVICE_ID_##v##_##d
>> PCI_DEVICE_ID_BROOKTREE_##chip
>> PCI_VENDOR_ID_##v
>> 
>> from:
>> 
>> linux-2.6.13-mm2/drivers/video/cirrusfb.c
>> linux-2.6.13-mm2/sound/oss/ymfpci.c
>> linux-2.6.13-mm2/sound/pci/bt87x.c
>> 
>> 
>> What is the goal here?  Is a comment stripped, non-duplicate pci_ids.h 
>> with a reference to source site okay? 
>
>Not sure what your last question is asking.  The current goal is to 
>remove completely unused symbols from pci_ids.h, nothing more.

Okay, ignore this part, I was thinking something else.
>
>
>> Should the various distributed defines be collected to the one header 
>> file and that header be include'd to those files?  It seems pci_ids.h 
>> is redundant.
>
>pci_ids.h should be the place where PCI IDs (class, vendor, device) are 
>collected.

Okay.
>
>Long term, we should be able to trim a lot of device ids, since they are 
>usually only used in one place.

Okay, dunno when, need to fix script and test some more, it's eating 
live symbols :(  Long time since I looked at this area.

Grant.

