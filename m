Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279079AbRKFLyc>; Tue, 6 Nov 2001 06:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279084AbRKFLyV>; Tue, 6 Nov 2001 06:54:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279079AbRKFLyI>; Tue, 6 Nov 2001 06:54:08 -0500
Subject: Re: Safe error numbers for User-defined return values
To: lkml@andyjeffries.co.uk (Andy Jeffries)
Date: Tue, 6 Nov 2001 11:57:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011106112216.24a769aa.lkml@andyjeffries.co.uk> from "Andy Jeffries" at Nov 06, 2001 11:22:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1614rf-0000HS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to define custom return values for my ioctl calls in my Kernel 
> module.  What is the recommended start value for user defined constants?  
> I notice asm/errno.h only goes up to 124 (in 2.4.12), so should I start at 
> 125 or should I start at 200 to be safe?
> 
> I probably only need 30 or so different codes.

You want to return non base errno codes in a different field and return
real errno codes by return value. If everyone simple invented private
returns for ioctl all hell would break loose
