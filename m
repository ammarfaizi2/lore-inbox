Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313720AbSDPPsp>; Tue, 16 Apr 2002 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313719AbSDPPsk>; Tue, 16 Apr 2002 11:48:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32773 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313722AbSDPPsR>; Tue, 16 Apr 2002 11:48:17 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 16 Apr 2002 17:05:44 +0100 (BST)
Cc: david.lang@digitalinsight.com (David Lang),
        dalecki@evision-ventures.com (Martin Dalecki),
        vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0204160825160.1167-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 16, 2002 08:30:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVSi-0000FN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doing it with a loopback like interface at a higher level is the much 
> saner operation - I understand why Martin removed the byteswap support, 
> and agree with it 100%. It just didn't make any sense from a driver 
> standpoint.

We need to support partitioning on loopback devices in that case.

> The only reason byteswapping exists is a rather historical one: Linux did 
> the wrong thing for "insw/outsw" on big-endian architectures at one point 
> (it byteswapped the data).

A small number of other setups people wired the IDE the quick and easy
way and their native format is indeed ass backwards - some M68K disks and
the Tivo are examples of that. Interworking requires byteswapping and the
ability to handle byteswapped partition tables.

Given the ability to see partitions on loop devices all works out I think

Alan
