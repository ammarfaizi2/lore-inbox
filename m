Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316156AbSEOMv1>; Wed, 15 May 2002 08:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSEOMv0>; Wed, 15 May 2002 08:51:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316156AbSEOMvZ>; Wed, 15 May 2002 08:51:25 -0400
Subject: Re: [PATCH] 2.5.15 IDE 61
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 15 May 2002 14:10:00 +0100 (BST)
Cc: nconway.list@ukaea.org.uk (Neil Conway),
        aia21@cantab.net (Anton Altaparmakov),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <3CE24040.4050001@evision-ventures.com> from "Martin Dalecki" at May 15, 2002 01:02:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177yXY-0001t9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that with the busy flag on we are wasting quite
> a significant amount of CPU time spinning around it for no good...

Why spin on the busy flag. Instead you just let the person who clears
the flag check the pending work and do it. 

