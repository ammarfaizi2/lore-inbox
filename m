Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312412AbSCYMR5>; Mon, 25 Mar 2002 07:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSCYMRq>; Mon, 25 Mar 2002 07:17:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312408AbSCYMRl>; Mon, 25 Mar 2002 07:17:41 -0500
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
To: flar@pants.nu (Brad Boyer)
Date: Mon, 25 Mar 2002 12:32:47 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        aia21@cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20020325115026.1FCAD24DB5@marcus.pants.nu> from "Brad Boyer" at Mar 25, 2002 03:50:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pTeZ-0000PD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> file unaligned.h. I suspect that at least some of
> these allow for an exception handler to fake the
> capability in user space programs, but that isn't
> something you can allow inside the kernel.

The Linux kernel assumes and requires that a processor handles alignment
faults and fixups in kernel space. 

This is done because there are many cases where an object is almost always
aligned and it is faster to assume alignment than to mess around with every
single chunk of data. Its tuned so those alignment traps should not be
occurring at a high rate.

Alan
