Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSA2NbO>; Tue, 29 Jan 2002 08:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSA2NbE>; Tue, 29 Jan 2002 08:31:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289294AbSA2NbA>; Tue, 29 Jan 2002 08:31:00 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Tue, 29 Jan 2002 13:43:38 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de
In-Reply-To: <200201291313.g0TDDd716906@ns.caldera.de> from "Christoph Hellwig" at Jan 29, 2002 02:13:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VYXy-0003xa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still don't think maintainig this array is worth just for hfs
> readahead, so the below patch disables it and gets rid of read_ahead.
> 
> Jens, could you check the patch and include it in your next batch of
> block-layer changes for Linus?

What would be significantly more useful would be to make it actually work.
Lots of drivers benefit from control over readahead sizes - both the
stunningly slow low end stuff and the high end raid cards that often want
to get hit by very large I/O requests (eg 128K for the ami megaraid)

Alan
