Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRJUQ4i>; Sun, 21 Oct 2001 12:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRJUQ42>; Sun, 21 Oct 2001 12:56:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30481 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276347AbRJUQ4T>; Sun, 21 Oct 2001 12:56:19 -0400
Subject: Re: how to invoke canonical processing in kernel
To: pjain@datatekcorp.com (Puneet Jain)
Date: Sun, 21 Oct 2001 18:03:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3BCC821E.9EA2C71C@datatekcorp.com> from "Puneet Jain" at Oct 16, 2001 02:53:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vM0I-0007I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> subsystem. So the processing that was handled by the 'ldterm' module on
> other OSs now has to be handled by the available line disciplines in the
> Linux kernel. While browsing the source I noticed that the default line

Linux is based on the BSD codebase. The streams disaster was one we chose
to skip over and ignore

> discipline N_TTY is probably sufficient to do the job but I am not sure
> of the hooks. I am wondering if I can invoke the default line discipline
> somehow or would I have to implement the canonical processing all over
> again.

Canonical processing is always part of the tty driver. The POSIX 
tcsetattr/tcgetattr calls let you configure which parts of it you need
(eg line processing, echo, character by character input etc)

Alan
