Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbULZSTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbULZSTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULZSSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:18:54 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:18553 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261725AbULZSSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:18:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FTxpvCeEkbI0SLKioeucaqW80pyWI7um8FqN5WJyAvCR8pp5LMyafleLcU9eT4WxCPTqwGqq/dKmH7C6ECxqT/nTJ9DeuugSV8N6u3L0ZHyPmwteT3u9ZwW8dNGfcf7kslNKE0dpRVPx5yKNeA93zTrsPaRZD5nvWiwad1oTMnA=
Message-ID: <58cb370e041226101846773b66@mail.gmail.com>
Date: Sun, 26 Dec 2004 19:18:44 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: is my RAID safe?
Cc: M Benz <mbenz74@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104080521.16049.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BAY15-F265CCA05303049813A8802B2980@phx.gbl>
	 <1104080521.16049.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004 17:02:04 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
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

Are you sure?  This is Promise SATA driver not IDE one.
