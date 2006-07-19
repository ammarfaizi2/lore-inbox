Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWGSAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWGSAaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWGSAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:30:38 -0400
Received: from aun.it.uu.se ([130.238.12.36]:21444 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932426AbWGSAai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:30:38 -0400
Date: Wed, 19 Jul 2006 02:29:59 +0200 (MEST)
Message-Id: <200607190029.k6J0TxrV021572@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mikpe@it.uu.se, sshtylyov@ru.mvista.com
Subject: Re: libata pata_pdc2027x success on sparc64
Cc: alan@redhat.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 22:07:44 +0400, Sergei Shtylyov wrote:
>> In contrast, the old IDE pdc202xx_new driver had lots
>> of problems with CRC errors causing it to disable DMA.
>
>    Hm, from my experience it usually falls back to UltraDMA/44 and then the 
>thing startrt working...
>
>> I wasn't able to manually tune it above udma3 without
>> getting more errors. This isn't sparc64-specific: I've
>> had similar negative experience with the old IDE Promise
>> drivers in a PowerMac.
>
>    This happens because the "old" driver misses the PLL calibration code.
>    You may want to try these Albert's patches:
>
>http://marc.theaimsgroup.com/?t=110992452800002&r=1&w=2
>http://marc.theaimsgroup.com/?t=110992471500002&r=1&w=2
>http://marc.theaimsgroup.com/?t=110992490100002&r=1&w=2
>http://marc.theaimsgroup.com/?t=111019238400003&r=1&w=2
>
>    It looks like they were never considered for accepting into the kernel
>while they succesfully solve this issue. Maybe Albert could try pushing them 
>into -mm tree once more?

Thank you for these links. After fixing up whitespace damage in
these four messages the patches applied OK and more importantly
eliminated _all_ misbehaviour from pdc202xx_new on both my sparc64
and my PowerMac.

These fixes belong in Linus' kernel, not some semi-obscure
mailing list archive.

/Mikael
