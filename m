Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293021AbSB1Ast>; Wed, 27 Feb 2002 19:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293100AbSB1AsH>; Wed, 27 Feb 2002 19:48:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293099AbSB1Ara>; Wed, 27 Feb 2002 19:47:30 -0500
Subject: Re: Linux 2.4.19pre1-ac1
To: afranck@gmx.de (Andreas Franck)
Date: Thu, 28 Feb 2002 01:02:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), florin@iucha.net (Florin Iucha),
        linux-kernel@vger.kernel.org
In-Reply-To: <02022801273203.01097@dg1kfa> from "Andreas Franck" at Feb 28, 2002 01:27:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gExc-0006hG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +               if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & 
> vma->vm_flags) )
> +                       return i ? : -EFAULT;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ <- This looks somewhat bogus, 
> shouldn't it be "return i ? i : -EFAULT;" instead?

Its the same thing - its an ugly Gcc extension.

One other person who reported the problem reports 2.4.18-ac2 is ok, in
which case it might be the slight mismerge in ac1 tho I'm puzzled why.
Certainly my testing here is behaving so far
