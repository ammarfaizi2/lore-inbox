Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280795AbRKBTFi>; Fri, 2 Nov 2001 14:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280797AbRKBTET>; Fri, 2 Nov 2001 14:04:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18184 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280791AbRKBSwa>; Fri, 2 Nov 2001 13:52:30 -0500
Subject: Re: bdevname(), cdevname(), kdevname() - static buffers
To: rweight@us.ibm.com (Russ Weight)
Date: Fri, 2 Nov 2001 18:59:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011102104211.A1279@us.ibm.com> from "Russ Weight" at Nov 02, 2001 10:42:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zjXF-0003Gs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was looking at the usage of bdevname(), cdevname(), and kdevname(),
> and noticed that they each return a pointer to a static buffer.
> This buffer contains a formatted device name, which is typically
> printed immediately following the call. However, I don't see any
> explicit lock protection for these buffers.
> 
> For SMP systems, is there something implicit in their use that
> prevents a race on these buffers? Has anyone seen garbled device
> names being printed (which might be attributed to a race)?

Not currently, other than statistics being on our side. It probably should
be touched up in 2.4 to use per cpu buffers and perhaps 2.5 pass a buffer
in
