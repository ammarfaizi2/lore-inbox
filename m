Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315255AbSEQMYZ>; Fri, 17 May 2002 08:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSEQMYY>; Fri, 17 May 2002 08:24:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315255AbSEQMYW>; Fri, 17 May 2002 08:24:22 -0400
Subject: Re: complain about dpt_2o driver and CPU time
To: davidchow@shaolinmicro.com (David Chow)
Date: Fri, 17 May 2002 13:42:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, deanna_bonds@adaptec.com
In-Reply-To: <3CE49230.40607@shaolinmicro.com> from "David Chow" at May 17, 2002 01:16:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178h4R-0006NH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> feel that the card is very slow, the test with Bonnie shows 1810KB/sec 
> with CPU load less than 2%. This shows the CPU time is idle, but the 
> load average go up to around 13-14 . This means the dpt_i2o driver is 

The load average includes I/O waiting. So that may well mean you have 14
different processes waiting for the card.

> even faster than this Ultra-160 SCSI i960 RAID with 32MB cache. If this 
> is the case, I will just throw it away and use my onboard Ultra-160 
> connector with software RAID which runs faster(at least). This is almost 
> unusable for even small workgroup server.

The numbers seem extremely poor. There are plenty of abysmally slow
RAID controllers out there but I'd expect bettere than 1810K/second even
on things like old Megaraid cards.

Alan
