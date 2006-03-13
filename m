Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWCMR2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWCMR2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWCMR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:28:42 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:11280 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932114AbWCMR2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:28:41 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Mon, 13 Mar 2006 17:13:31 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1142262431.25773.25.camel@localhost.localdomain> <200603131639.51594.s0348365@sms.ed.ac.uk>
In-Reply-To: <200603131639.51594.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131713.31411.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 16:39, Alistair John Strachan wrote:
> On Monday 13 March 2006 15:07, Alan Cox wrote:
> > Available from
> >
> > http://zeniv.linux.org.uk/~alan/IDE/
>
> Alan, I've been using your patchset for a while on a small-memory machine
> with an AMD IDE controller, so that the legacy PATA port can be used to run
> an optical drive without bloating the vmlinux size with ide-* (already have
> SCSI built in for usb-storage and SATA). I've not had a single problem to
> date.

However, I just tried the same driver on my desktop PC (4xSATA HDs, 1xPATA) 
and I get the following periodically (when the PATA device is NOT being 
used):

ata1: irq trap
ata1: command 0x25 timeout, stat 0x50 host_stat 0x20
ata2: irq trap
ata2: command 0xca timeout, stat 0x50 host_stat 0x20
ata4: irq trap
ata4: irq trap
ata4: irq trap
ata4: irq trap
ata4: command 0xc8 timeout, stat 0x50 host_stat 0x20

ata1-4 are the HDs, ata5 is the PATA device (it does not trigger).

This could however be some bug in 2.6.16-rc6, the last kernel on this box with 
2.6.16-rc4 without your IDE patches.

Any ideas?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
