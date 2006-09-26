Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWIZPrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWIZPrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIZPrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:47:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:1742 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751265AbWIZPrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:47:21 -0400
From: Andi Kleen <ak@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] arch/i386/pci/mmconfig.c tlb flush fix
Date: Tue, 26 Sep 2006 17:47:09 +0200
User-Agent: KMail/1.9.3
Cc: Greg KH <greg@kroah.com>, OGAWA Hirofumi <hogawa@miraclelinux.com>,
       linux-kernel@vger.kernel.org
References: <lry7s7t1su.fsf@dhcp-0242.miraclelinux.com> <p73y7s6kebe.fsf@verdi.suse.de> <87mz8mzl6k.fsf@duaron.myhome.or.jp>
In-Reply-To: <87mz8mzl6k.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609261747.09923.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 17:45, OGAWA Hirofumi wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > OGAWA Hirofumi <hogawa@miraclelinux.com> writes:
> >> 
> >> We use the fixmap for accessing pci config space in pci_mmcfg_read/write().
> >> The problem is in pci_exp_set_dev_base(). It is caching a last
> >> accessed address to avoid calling set_fixmap_nocache() whenever
> >> pci_mmcfg_read/write() is used.
> >
> >
> > Good catch. I already had another report of mmconfig corruption on i386,
> > but didn't have time to look at it yet.
> >
> > Will be definitely stable material once it hit mainline.
> 
> Indeed.
> 
> If I found this in mainline, should I send something like a reminder
> email with patch to you, Greg?

I have it already queued for both.

-Andi
