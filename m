Return-Path: <linux-kernel-owner+w=401wt.eu-S964887AbWLNWc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWLNWc7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWLNWc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:32:59 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1115 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964887AbWLNWc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:32:58 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux 2.6.20-rc1
Date: Thu, 14 Dec 2006 22:33:10 +0000
User-Agent: KMail/1.9.5
Cc: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612142144.26023.s0348365@sms.ed.ac.uk> <4581C73F.6060707@garzik.org>
In-Reply-To: <4581C73F.6060707@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612142233.10584.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 21:50, Jeff Garzik wrote:
> Alistair John Strachan wrote:
> > Before I proceed with the horrors of an -rc1 bisection, could somebody
> > send me the ADMA patches so I can eliminate those first?
>
> Run
>
> 	git-whatchanged drivers/ata/sata_nv.c
>
> and that will give you a list of recent changes.  To obtain the "diff
> -u" patch for a single commit, run
>
> 	git-diff-tree -p $SHA_HASH > /tmp/patch

I used a variation on this:

	git-whatchanged -p v2.6.19.. drivers/ata/sata_nv.c >sata_nv

Reverted it (against v2.6.20-rc1), compiled that kernel, no dice.

[root] 22:32 [~] hddtemp /dev/sda
/dev/sda: ATA WDC WD2500KS-00M: S.M.A.R.T. not available

I'll start the bisection.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
