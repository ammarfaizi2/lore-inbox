Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280665AbRKFXN2>; Tue, 6 Nov 2001 18:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280667AbRKFXNJ>; Tue, 6 Nov 2001 18:13:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5391 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280665AbRKFXM6>; Tue, 6 Nov 2001 18:12:58 -0500
Subject: Re: Using %cr2 to reference "current"
To: dalecki@evision.ag
Date: Tue, 6 Nov 2001 23:19:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BE879A0.E06DE631@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2001 01:00:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161FVT-00029X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we are talking about memmory bload. Let's usk a question. Is somebody
> there
> working seriously on changing the default function call conventions on
> IA32

Thats pure noise

On a 256Mb machine you have 65536 page map entries. Those are 64 bytes but
its not hard to get it down to 56 bytes (.5Mb saved) and probably to 48
bytes. We can probably also shave 8 bytes off each cached inode if not
more (the nfs changes in -ac are a big help there already) - thats typically
another 200K on a reasonable size box - and the new bootmem code can save a
chunk too

Im not sure how much the code change for function call patterns would be
but I doubt its so big for such little effort

Alan
