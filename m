Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVDENmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVDENmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVDENmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:42:24 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:60966 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261736AbVDENmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UcoUiAUtzQlUL2R/hWUXCeK7qtr8ILXBGEzanbiifxYP0Op+1eAR8QF3pK0eqIEyqwbV9NkGHcMNBBg4ltBqdFIYBm5gZJN1h96PzocxyoMNQj31av4Q29X1go/NrntYznLGe45FqcZA5tslhsHnKMX5Imnp322XWW10Cn1TEu0=
Message-ID: <2a0fbc5905040506422fbf6356@mail.gmail.com>
Date: Tue, 5 Apr 2005 15:42:14 +0200
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <2a0fbc59050325145935a05521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2005 12:59 AM, Julien Wajsberg <julien.wajsberg@gmail.com> wrote:
> I own an Asus A8N-Sli motherboard with the Nforce4-Sli chipset, and I
> experiment the following problem :
> 
> Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
> Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
> Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
> Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Mar 25 22:42:55 evenflow kernel:
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
> Mar 25 22:42:55 evenflow kernel:
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> 
> Of course, if I disable DMA with hdparm, this problem disappear.. but
> it isn't a long-term solution ;-)
> 
> Using vanilla 2.6.11.5 kernel. I attached the config file.

I tried the multidma mode (as opposed to ultradma), and the system
hanged immediately. (Thanks to the patched-for-netpoll forcedeth
driver), I got the following message:

Unknown interrupt or fault at EIP 00000206 00000060 c0247a3a

There's definitely something wrong here...
I'm still using the same setup as in my first mail.

-- 
Julien
