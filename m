Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314592AbSDTIdS>; Sat, 20 Apr 2002 04:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314595AbSDTIdR>; Sat, 20 Apr 2002 04:33:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314592AbSDTIdQ>; Sat, 20 Apr 2002 04:33:16 -0400
Subject: Re: [RFC] 2.5.8 sort kernel tables
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 20 Apr 2002 09:50:53 +0100 (BST)
Cc: prandal@herefordshire.gov.uk (Randal Phil), linux-kernel@vger.kernel.org
In-Reply-To: <16167.1019279955@ocs3.intra.ocs.com.au> from "Keith Owens" at Apr 20, 2002 03:19:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yqa5-0000Qs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It requires extra storage which is unacceptable.  The kernel tables
> must be sorted before any code that might take an exception is used.
> The sort must be done very early, before kernel memory management is
> setup.  In addition, the kernel stack has a limited size.

Why not sort them after linking and before you boot the kernel. This sounds
like a job for libbfd after link. I hadn't realised you planned to do the 
sort every boot

Alan
