Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269817AbUIDFr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269817AbUIDFr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 01:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269815AbUIDFr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 01:47:28 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:29841 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269817AbUIDFr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 01:47:26 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1 : Weirdness after shutdown - ACPI or Suspend bug?
Date: Sat, 4 Sep 2004 15:47:45 +1000
User-Agent: KMail/1.7
Cc: len.brown@intel.com
References: <200409012020.42482.cef-lkml@optusnet.com.au> <200409012352.21576.cef-lkml@optusnet.com.au>
In-Reply-To: <200409012352.21576.cef-lkml@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041547.45788.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 23:52, Stuart Young wrote:
> On Wed, 1 Sep 2004 20:20, Stuart Young wrote:
> > OK, this one is weirding me out.
> >
> > Note that when using 2.6.8.1 all is fine. The following situation only
> > happens in 2.6.9-rc1 or later.
> >
> > If I shutdown my laptop (ie: halt) it goes through the motions and
> > everything goes off. If the lid switch changes state AFTER powerdown, the
> > laptop starts up. Removing AC power, or with AC power connected and
> > removing the battery does not trigger this, just seemingly the lid
> > switch. This works on lid close, AND lid open.
>
> Len, I've tentatively traced this down to the addition of the ACPI
> wakeup_devices module that went into the kernel via ACPI 20040715.
>
> From a quick look at the code, the wakeup devices get set at boot, but on
> shutdown, they don't get unset. Is this intentional?
>
> Any clues, ideas, or suggestions?
>
> Notes:
>  Asus L7300/L7200 series laptop
>  Latest BIOS from the Asus website
>  PIII-600 on Intel 82440MX chipset

Further info. Using 2.6.9-rc1-mm3 does not change this behaviour at all. Seems 
that 2.6.9-rc1-mm3 contains 20040816, so this is still a running issue.
