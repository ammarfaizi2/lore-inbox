Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUIANy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUIANy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUIANxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:53:46 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:45958 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266680AbUIANwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:52:18 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1 : Weirdness after shutdown - ACPI or Suspend bug?
Date: Wed, 1 Sep 2004 23:52:20 +1000
User-Agent: KMail/1.7
References: <200409012020.42482.cef-lkml@optusnet.com.au>
In-Reply-To: <200409012020.42482.cef-lkml@optusnet.com.au>
Cc: len.brown@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200409012352.21576.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004 20:20, Stuart Young wrote:
> OK, this one is weirding me out.
>
> Note that when using 2.6.8.1 all is fine. The following situation only
> happens in 2.6.9-rc1 or later.
>
> If I shutdown my laptop (ie: halt) it goes through the motions and
> everything goes off. If the lid switch changes state AFTER powerdown, the
> laptop starts up. Removing AC power, or with AC power connected and
> removing the battery does not trigger this, just seemingly the lid switch.
> This works on lid close, AND lid open.

Len, I've tentatively traced this down to the addition of the ACPI 
wakeup_devices module that went into the kernel via ACPI 20040715.

>From a quick look at the code, the wakeup devices get set at boot, but on 
shutdown, they don't get unset. Is this intentional?

Any clues, ideas, or suggestions?

Notes:
 Asus L7300/L7200 series laptop
 Latest BIOS from the Asus website
 PIII-600 on Intel 82440MX chipset

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
