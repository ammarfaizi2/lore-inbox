Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285136AbRLFODJ>; Thu, 6 Dec 2001 09:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285135AbRLFOC7>; Thu, 6 Dec 2001 09:02:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39948 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285136AbRLFOCr>; Thu, 6 Dec 2001 09:02:47 -0500
Subject: Re: Adaptec-2920 eats too much cpu time when reading from the CD-ROM
To: florin@iucha.net (Florin Iucha)
Date: Thu, 6 Dec 2001 14:11:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), florin@iucha.net (Florin Iucha),
        linux-kernel@vger.kernel.org, faith@acm.org
In-Reply-To: <20011206075125.A23432@beaver.iucha.org> from "Florin Iucha" at Dec 06, 2001 07:51:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BzFk-0001m3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is one interesting thing about it: when I write a CD, I write at 12x
> - that means 1800Kb/s, which is comparable with the reading speed of 2400Kb/s.
> But when writing, the system CPU usage is about 30%.

When you write the scsi layer keeps getting to the point where there are
no commands to issue. When you read its always there waiting for the drive.

