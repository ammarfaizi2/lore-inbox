Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRLGNjx>; Fri, 7 Dec 2001 08:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLGNjk>; Fri, 7 Dec 2001 08:39:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281059AbRLGNjU>; Fri, 7 Dec 2001 08:39:20 -0500
Subject: Re: 2GB process crashing on 2.4.14
To: Paul.Sargent@3dlabs.com (Paul Sargent)
Date: Fri, 7 Dec 2001 13:48:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011207132317.E31161@3dlabs.com> from "Paul Sargent" at Dec 07, 2001 01:23:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CLM9-0005rf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Most probably the process is running out of address space to allocate from.
> > There is 3Gb of available space. 
> 
> That would be from 0x00000000 to 0xC0000000, Right?

Correct (0xBFFFFFFF)

> > binary, some your libraries.  Getting above 3Gb/process on x86 is very hairy
> > with a bad performance hit
> 
> So if I was hitting this limit then I should see no / very few gaps, in the
> /proc/<pid>/maps. Is that true?

Providing the memory allocator it is using is sufficiently smart
