Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285458AbRLGKbQ>; Fri, 7 Dec 2001 05:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRLGKav>; Fri, 7 Dec 2001 05:30:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1801 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285458AbRLGKaf>; Fri, 7 Dec 2001 05:30:35 -0500
Subject: Re: kernel: ldt allocation failed
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Fri, 7 Dec 2001 10:38:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vkire@pixar.com (Kiril Vidimce),
        dmaas@dcine.com (Dan Maas),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Dec 07, 2001 09:45:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CIPD-0005Mi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the vmalloc() fails, the new_mm->context.segments is set to NULL and 
> the function returns.
> 
> That seems wrong, no? Shouldn't there be a panic() when the allocation 
> fails at least? Or even better the function should perhaps return an error 
> code?
> 
> Considering there is only one caller (kernel/fork.c::copy_mm()) it would be 
> easy to modify copy_mm() to handle a returned error code gracefully and 

That sounds like an appropriate change.
