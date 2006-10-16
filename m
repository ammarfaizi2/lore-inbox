Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161192AbWJPAWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWJPAWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWJPAWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:22:00 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:54699 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161192AbWJPAV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:21:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MDr9DKutlnjgkKQDVE6FK1l5CxUoU4uGAAG76hwXMrsN6Wfk5gTCBrdNf1w0az6TtcvBieax+zxr/iAKfgbFjHtP7d8lJSqZ3swKl+bEsvuTsqZhJqJpHJfweR1MSM4PSY100AcSEtljm98Ek1DdVPOTBm/HwtsMWZnbpoceIP0=  ;
From: David Brownell <david-b@pacbell.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Date: Sun, 15 Oct 2006 17:21:53 -0700
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx> <20061015104544.5de31608.akpm@osdl.org> <17714.52121.962807.781244@cargo.ozlabs.ibm.com>
In-Reply-To: <17714.52121.962807.781244@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610151721.54873.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If the drivers doesn't care and if it makes no difference to performance
> > then just delete the call to pci_set_mwi().
> > 
> > But if MWI _does_ make a difference to performance then we should tell
> > someone that it isn't working rather than silently misbehaving?

To repeat:  it's not "misbehaving" since support for MWI cycles is
completely optional.  It'd be more interesting to get messages in
the cases that it can be enabled, since typically it can't be.


> That sounds like we need a printk inside pci_set_mwi then, rather than
> adding a printk to every single caller.

Maybe wrapped in #ifdef CONFIG_SPAM_MY_KERNEL_LOG_MESSAGES ... :)

