Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSECNfo>; Fri, 3 May 2002 09:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSECNfn>; Fri, 3 May 2002 09:35:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312411AbSECNfm>; Fri, 3 May 2002 09:35:42 -0400
Subject: Re: Custom Driver to Serial Driver Read Interface Problem
To: Abdij.Bhat@kshema.com (Abdij Bhat)
Date: Fri, 3 May 2002 14:53:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        linux-mips-kernel@lists.sourceforge.net ('linux-mips-kernel@lists.sourceforge.net'),
        Abdij.Bhat@kshema.com (Abdij Bhat),
        Preetesh.Parekh@kshema.com (Preetesh Parekh)
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10137057@BHISHMA> from "Abdij Bhat" at May 03, 2002 02:33:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173dVW-0006N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I am writing a kernel mode device driver which needs to read and write data
> from serial port ( /dev/ttyS1 in this case ).

You want to be a line discipline. Take a look at slip.c as an example. Thats
a line discipline one end and a network protocol the other. It gets called 
when there is stuff for reading and room to send, it has calls to send more
data
