Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVJFHe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJFHe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVJFHe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 03:34:27 -0400
Received: from web30312.mail.mud.yahoo.com ([68.142.201.230]:32916 "HELO
	web30312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750708AbVJFHe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 03:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zYqq75Hs1FEHA4gzBWuVNFDcwO3xCsvs7Dec5HCrpZnuk24LPnuS5hZmzvOQa6ZlfmuHnHWeFiQd5Plbw+qinfNgrc4/ZBdFbOMBGqTinj5RsUOsrP1uDYR+7ihMp1BVmD42CmGP5R0g3/ctC7my0kvlZ37px3XMHUeBNtzaLz0=  ;
Message-ID: <20051006073425.42519.qmail@web30312.mail.mud.yahoo.com>
Date: Thu, 6 Oct 2005 00:34:25 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0510050931140.11806@dark.webcon.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "Ian E. Morgan" <imorgan@webcon.ca> wrote:

> I have seen some systems on which IRQ load balancing
> can have a detrimental
> effect on some devices such as gigabit Ethernet etc.
> 
> You could try disabling both the irqbalance
> userspace daemon (if that's part
> of your distribution), and in-kernel IRQ balancing,
> if enabled
> (CONFIG_IRQBALANCE).

I don't have a userspace daemon for that, but I'll try
the kernel option.

> 
> For your NIC, try enabling NAPI interrupt
> mitigation, if available. This
> will significantly reduce the interrupt load under
> high traffic volume.

It's always enabled in my configs.

> I guess there's another obvious question that I
> forgot: Do you have the
> 3ware cache enabled or disabled? Are your ext3
> filesystems mounted with the
> 'noatime' option?

Write caching is enabled. I don't have much activity
across thousands of files so noatime is less
ciritical, but the RAID volume is still mounted
noatime.

So basically I'll try the irq load balancing and see
whath happens.

Thanks



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
