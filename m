Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWH1InQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWH1InQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWH1InQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:43:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:17968 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751302AbWH1InP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:43:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I3d8TqyR8FOOubaWZm1afn5uI1dKC0R2jmOzgUzB87caTKvGC3+8AUPsuYwRDyRIFi3mAtHmEQzDJe+qVaXN0MBEy3qfLNaxitFNY53EfM5tc8Ir399O8/RqDKcSO/+pK1wgPTZs9S6+Yg/2+snBBGnm1jvaDiCuMnlsF5KZ+1Q=
Message-ID: <44F2AC6E.90608@gmail.com>
Date: Mon, 28 Aug 2006 17:42:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5
References: <13331.1156754096@kao2.melbourne.sgi.com>
In-Reply-To: <13331.1156754096@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Two hours of continuous reboots on an ICH5 chipset passed without any
> problems.  Couple of caveats though -
> 
> (1) The "fix" for this bug is to skip the pcs test for SATA ports on
>     ICH5 chipsets.  This results in spurious warning messages for ICH5
>     SATA ports with no disks attached.
> 
>     ATA: abnormal status 0x7F on port 0xCCA7

This is a known annoyance and will be fixed in time.

> (2) I have seen the same intermittent bug on ICH7 SATA but
>     PIIX_FLAG_IGNORE_PCS is only set for ich5 and i6300esb_sata.  It
>     probably needs to be set for ich7 as well.

No, ICH7 up to this point has been believed to have well-behaving PCS. 
If you report PCS problem, you'll be the first.  Also, note that ICH7 
suffers from ghost device probing problem if PCS is not honored exactly. 
  Are you sure it's the same problem?

Thanks.

-- 
tejun
