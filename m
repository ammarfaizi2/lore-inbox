Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFOMSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFOMSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFOMSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:18:30 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:15513 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261423AbVFOMSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:18:25 -0400
Date: Wed, 15 Jun 2005 08:18:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-reply-to: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
To: linux-kernel@vger.kernel.org
Cc: cutaway@bellsouth.net
Message-id: <200506150818.24465.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 June 2005 04:53, cutaway@bellsouth.net wrote:
>In find_first_bit() there exists this the sequence:
>
>shll $3,%%edi
>addl %%edi,%%eax
>
>LEA knows how to multiply by small powers of 2 and add all in one
> shot very efficiently:
>
>leal (%%eax,%%edi,8),%%eax
>
>
>In find_first_zero_bit() the sequence:
>
>shll $3,%%edi
>addl %%edi,%%edx
>
>could similarly become:
>
>leal (%%edx,%%edi,8),%%edx
>
To what cpu families does this apply?  eg, this may be true for intel, 
but what about amd, via etc?
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
