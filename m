Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031139AbWFOTCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031139AbWFOTCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031138AbWFOTCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:02:09 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:24718 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1031136AbWFOTCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:02:07 -0400
Message-ID: <4491AEAC.5030606@drzeus.cx>
Date: Thu, 15 Jun 2006 21:02:04 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: dezheng shen <dzshen@winbond.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PI14 SJIN <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers
References: <448E875A.40805@winbond.com> <9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com> <448FC0C1.90205@winbond.com>
In-Reply-To: <448FC0C1.90205@winbond.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dezheng shen wrote:
> Hi Jesper and all others:
> 
>>  please post patches inline, not as attachments (and please
>> test send those mails to yourself first and check that the patches
>> apply and have not been mangled by your email client).
> 
> 
>  We are submittting patches; instead, we are submit the original sources
> for Winbond SD/MMC/MS/MSPro/xD/SM devicers. There are too many files and
> I am afraid once we copy and paste using plain text then the whole
> things do'nt look clear to you guys.

People are quite used to reading diffs, so it's not that much of a bother.

> 
>  Can we pack our sources then send them in one large attachment?
> 

Uncompressed attachments, or inline inclusions, are usually preferred as
it allows you to read the stuff in your mail application.

I have one reservation with your driver though. The Linux kernel already
has a generic SD/MMC layer. So if your hardware is a bus interface, then
it should use that layer. There is even a driver there for your
W83L518/9 devices. :)

For the other buses, a generic layer would be preferable, but as you
would be the only user, that isn't required quite yet. I would suggest
contacting Andrew Morton as he is the overall 2.6 maintainer.

Rgds
Pierre

PS. I have a question regarding the W83L518 hardware, but haven't been
able to get in touch with the right people. Perhaps you have some pointers?
