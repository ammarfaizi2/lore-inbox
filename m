Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWIZPpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWIZPpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWIZPpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:45:19 -0400
Received: from mail.parknet.jp ([210.171.160.80]:62473 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751251AbWIZPpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:45:16 -0400
X-AuthUser: hirofumi@parknet.jp
To: Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>
Cc: OGAWA Hirofumi <hogawa@miraclelinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386/pci/mmconfig.c tlb flush fix
References: <lry7s7t1su.fsf@dhcp-0242.miraclelinux.com>
	<p73y7s6kebe.fsf@verdi.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 27 Sep 2006 00:45:07 +0900
In-Reply-To: <p73y7s6kebe.fsf@verdi.suse.de> (Andi Kleen's message of "26 Sep 2006 14\:22\:29 +0200")
Message-ID: <87mz8mzl6k.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> OGAWA Hirofumi <hogawa@miraclelinux.com> writes:
>> 
>> We use the fixmap for accessing pci config space in pci_mmcfg_read/write().
>> The problem is in pci_exp_set_dev_base(). It is caching a last
>> accessed address to avoid calling set_fixmap_nocache() whenever
>> pci_mmcfg_read/write() is used.
>
>
> Good catch. I already had another report of mmconfig corruption on i386,
> but didn't have time to look at it yet.
>
> Will be definitely stable material once it hit mainline.

Indeed.

If I found this in mainline, should I send something like a reminder
email with patch to you, Greg?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
