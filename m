Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULZUrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULZUrB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULZUrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:47:01 -0500
Received: from [81.23.229.73] ([81.23.229.73]:63372 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261161AbULZUq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:46:59 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: linux-kernel@vger.kernel.org
Subject: Re: is my RAID safe?
Date: Sun, 26 Dec 2004 21:46:55 +0100
User-Agent: KMail/1.6.2
References: <BAY15-F265CCA05303049813A8802B2980@phx.gbl> <1104080521.16049.6.camel@localhost.localdomain>
In-Reply-To: <1104080521.16049.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200412262146.55121.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 18:02, you wrote:
> On Sul, 2004-12-26 at 14:30, M Benz wrote:
> > Today I found this that at my /var/log/message (kernel 2.6.10):
> >
> > Dec 26 21:35:14 s1 kernel: ata5: status=0x51 { DriveReady SeekComplete
> > Error }
> > Dec 26 21:35:14 s1 kernel: ata5: error=0x84 { DriveStatusError BadCRC }
> >
> > ata5 is md raid1 with ata6, both are sata drives connected to a promise
> > SATA controller.
>
> BadCRC is usually cable noise. The kernel will retry such an event
> several times, then fall back to PIO and try that before it gives up.

In other words: The data to disk and from disk is consistent, so the data is 
safe.

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
