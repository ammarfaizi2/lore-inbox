Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWCNKst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCNKst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWCNKst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:48:49 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:5641 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932165AbWCNKss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:48:48 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Tue, 14 Mar 2006 10:48:39 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1142262431.25773.25.camel@localhost.localdomain> <200603131713.31411.s0348365@sms.ed.ac.uk> <1142299457.25773.43.camel@localhost.localdomain>
In-Reply-To: <1142299457.25773.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141048.39785.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 01:24, Alan Cox wrote:
> On Llu, 2006-03-13 at 17:13 +0000, Alistair John Strachan wrote:
> > However, I just tried the same driver on my desktop PC (4xSATA HDs,
> > 1xPATA) and I get the following periodically (when the PATA device is NOT
> > being used):
>
> Can you try the vanilla rc6 kernel to check, and if it does it then let
> Jeff Garzik known ASAP - especially if rc4 was ok.
>
> > ata1: irq trap

No such error without your patch on this machine. I've got a RAID5 spanning 
four SATA drives on a dual core Athlon 64, and it'll happily do 185MB/s 
to /dev/null with the command:

for FILE in *; do dd if="$FILE" of=/dev/null bs=1M; done

300,000 interrupts later, still no messages. Anything I can do to isolate this 
further?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
