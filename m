Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWCWHxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWCWHxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWCWHxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:53:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030187AbWCWHxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:53:00 -0500
Date: Wed, 22 Mar 2006 23:49:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: kernel@kolivas.org, johnstul@us.ibm.com, andi@rhlx01.fht-esslingen.de,
       bert.hubert@netherlabs.nl, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not
 buggy
Message-Id: <20060322234909.4e9cd987.akpm@osdl.org>
In-Reply-To: <87irq539e2.fsf@duaron.myhome.or.jp>
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
	<87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
	<20060322134633.46389249.akpm@osdl.org>
	<87irq539e2.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
>  > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>  >>
>  >> +	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
>  >> +			     PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
>  >>
>  >> ...
>  >>
>  >> +device_initcall(pmtmr_bug_check);
>  >
>  > Can this code use the PCI quirk infrastructure?
> 
>  Yes. However, since we need to check there is _not_ those chipsets,

Oh.  Probably not worth bothering with then.
