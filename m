Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136567AbREDXZt>; Fri, 4 May 2001 19:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136571AbREDXZj>; Fri, 4 May 2001 19:25:39 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:29344 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S136567AbREDXZT>; Fri, 4 May 2001 19:25:19 -0400
Date: Fri, 04 May 2001 16:23:49 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] pegasus + MediaGX: Oops in khubd,
 the continuing story?
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Message-id: <0ba601c0d4f1$46c07a00$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <E14vnVb-00085n-00@the-village.bc.nu>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the ohci driver currently. I've been reviewing it a little and it
> is full of code written by someone who does not know about pci write posting.

I think there's a lot of that going around ... I don't think any of what you
mentioned was in the Documentation/pci.txt writeup, or any other source
of kernel documentation I found when I started to look at at that code!

That diagnosis works as well with the known facts as any other; maybe
better, considering some of the info I've collected offline.  And it could
also explain some other intermittent failures.


> You have to do
> 
> writel(STOP, reg->dmactrl);
> [posted]
> readl(reg->dmactrl)
> [read forces write, read reply will follow any DMA
> pending the other way]

Good to know.  That'd apply for any register read, not just the
one that was written to, yes?

- Dave


