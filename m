Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSEIOla>; Thu, 9 May 2002 10:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEIOl2>; Thu, 9 May 2002 10:41:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29194 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313202AbSEIOk5>; Thu, 9 May 2002 10:40:57 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: ltd@cisco.com (Lincoln Dale)
Date: Thu, 9 May 2002 15:58:48 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <5.1.0.14.2.20020509122919.01645ff0@mira-sjcm-3.cisco.com> from "Lincoln Dale" at May 09, 2002 12:37:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175pNZ-0003tT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> doing the same test thru the block-layer was basically capped at around 
> 135mbyte/sec.  (simultaneous "dd if=/dev/sdX of=/dev/null bs=512 count=35M").

Tweak your dd to use O_DIRECT and use an O_DIRECT capable fs - that tells
you if its copy overhead or disk side stuff.
