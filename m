Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSAMBMi>; Sat, 12 Jan 2002 20:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287892AbSAMBM2>; Sat, 12 Jan 2002 20:12:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287886AbSAMBMN>; Sat, 12 Jan 2002 20:12:13 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 01:23:25 +0000 (GMT)
Cc: yodaiken@fsmlabs.com, landley@trommello.org (Rob Landley),
        rml@tech9.net (Robert Love), alan@lxorguk.ukuu.org.uk (Alan Cox),
        nigel@nrg.org, akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C40A8EF.D45600E3@linux-m68k.org> from "Roman Zippel" at Jan 12, 2002 10:21:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZMr-0003fE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So even the low priority process will have the same time as before to do
> it's job, it will be delayed, but it will not be delayed forever, so I'm
> failing to see how preempting Linux should deadlock.

First task scheduled takes a resource that a second task needs. 150 other
threads schedule via pre-emption, the one that it should share the resource
with cannot run but the rest do. Repeat. It doesn't deadlock but it goes
massively unfair

