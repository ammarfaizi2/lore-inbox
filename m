Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbREVSRK>; Tue, 22 May 2001 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbREVSQ7>; Tue, 22 May 2001 14:16:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37138 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262699AbREVSQr>; Tue, 22 May 2001 14:16:47 -0400
Subject: Re: [PATCH] include/linux/coda.h
To: bodnar42@bodnar42.dhs.org (Ryan Cumming)
Date: Tue, 22 May 2001 19:06:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jaharkes@cs.cmu.edu (Jan Harkes),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0105220924560.32368-100000@bodnar42.dhs.org> from "Ryan Cumming" at May 22, 2001 09:40:19 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152GYM-0002GF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When compiling the kernel under FreeBSD, __KERNEL__ is defined, but
> __linux__ is not. I think this is an error on the part of the header file,
> because on non-Linux build environments, which would otherwise compile the
> Linux kernel correctly, do not have __linux__ defined.

Thats a problem with your compiler setup.

> However, not many people will probably find much use in compiling the
> kernel on other platforms, so if you think this isn't worth inclusion, I
> totally understand. I'm in the process of porting UML to FreeBSD, and
> having this patch in the tree would make my job slightly easier.

Teaching your gcc to do -D__linux__ would be cleaner and also catch the
zillion other cases that simply came out wrong instead of erroring

One shell script for your CC and off you go


