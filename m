Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbRF3H1y>; Sat, 30 Jun 2001 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbRF3H1o>; Sat, 30 Jun 2001 03:27:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19470 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264867AbRF3H1g>; Sat, 30 Jun 2001 03:27:36 -0400
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sat, 30 Jun 2001 08:26:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <200106300435.VAA14173@adam.yggdrasil.com> from "Adam J. Richter" at Jun 29, 2001 09:35:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GF94-0001h6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I do not understand what you (Alan) mean by the "'conflicts with'"
> usage.  I do not believe there is any way to directly use dep_* to express
> that a "y" answer to some feature requires "n" or even "m" for another
> feature.

Uses for dep_tristate

#1

	dep_tristate $FOO $BAR

to say 'FOO requires BAR and must be a similar setting'


#2
	dep_tristate $FOO $BAR

to say 'FOO requires BAR and must be a similar setting _IF_CONFIGURED_'

Think about Plug and Play

A driver needs to be modular if PnP is modular, but with a non PnP kernel
can be Yes even if PNP is off. 

Alan

