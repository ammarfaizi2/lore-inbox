Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284037AbRLAJuc>; Sat, 1 Dec 2001 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284045AbRLAJuW>; Sat, 1 Dec 2001 04:50:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284042AbRLAJuH>; Sat, 1 Dec 2001 04:50:07 -0500
Subject: Re: [PATCH] task_struct colouring ...
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 1 Dec 2001 09:58:36 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
In-Reply-To: <3C083150.3060906@zytor.com> from "H. Peter Anvin" at Nov 30, 2001 05:24:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A6uq-0006e2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > movl %esp, %eax
> > andl $-8192, %eax
> > movl (%eax), %eax
> 
> This seems to confuddle the idea of colouring the kernel stack.

It means you cant offset the stacks but doesnt mean you can't jitter them.
If you pull the task out of the stack top you have another 1K or so free
to use to vary the initial %esp
