Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284053AbRLELSS>; Wed, 5 Dec 2001 06:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284078AbRLELSJ>; Wed, 5 Dec 2001 06:18:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61711 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284053AbRLELRu>; Wed, 5 Dec 2001 06:17:50 -0500
Subject: Re: Maximum heap size?
To: adam-dated-1007982419.3acea7@flounder.net (Adam McKenna)
Date: Wed, 5 Dec 2001 11:26:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011205030653.F15577@flounder.net> from "Adam McKenna" at Dec 05, 2001 03:06:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BaCW-0005xK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been STFW'ing for a few hours now and I keep finding conflicting
> reports on what the maximum heap size is with Linux 2.4.  Some places say it
> is 1GB, and others say it is unlimited.

You have 3Gb of virtual space for an application on x86. This is basically
hardware limitations of the processor (1Gb is used for kernel mappings and
having kernel and user mappings overlapping costs every syscall)

If you are hitting a 1GB limit I would assume the jvm isn't very bright
about its allocation of resources. You should run out at something like
2.5Gb of allocations. (you lose some to app and library maps)

Alan
