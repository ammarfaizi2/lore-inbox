Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWEQEtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWEQEtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWEQEtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:49:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:52339 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751256AbWEQEtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:49:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=P8n6SvjWmnDFo60+aWIVU3STqtaaEIN5ZIWRl/WPxpGg+3WYmLvHUZx21Tl4Qmzf6UXIJmAMFg1QI3FrbHZmgwk/CIAYbfa8kSf145iPyTVkr0UBTKlkv0ZEA3NTfJXPz153Zjne46ZRTEFeYpVHyYNNpGY2UAN7elMnEGWhkE8=
Message-ID: <446AAB3C.6050303@gmail.com>
Date: Wed, 17 May 2006 13:49:00 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060516190507.35c1260f.akpm@osdl.org>
In-Reply-To: <20060516190507.35c1260f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

Andrew Morton wrote:
[--snip--]
> [   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> [   44.719425] ata2.00: ATAPI, max UDMA/66
> [   44.765263] ata2.00: applying bridge limits
> [   74.928836] ata2.01: qc timeout (cmd 0xa1)
> [   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
> [   75.468856] ata2.00: ATAPI, max UDMA/66
> [   75.514678] ata2.00: applying bridge limits
> [  105.674130] ata2.01: qc timeout (cmd 0xa1)

Did this device work with previous versions of kernel?

libata used to give up on the first failure during probe, so the boot 
time would have been shorter in failure cases.  I think controlled 
retries during boot probe is a good thing, but the timeout of 30s for 
IDENTIFY commands can be shortened, I guess.

-- 
tejun
