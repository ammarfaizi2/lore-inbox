Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbREVSLs>; Tue, 22 May 2001 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbREVSLi>; Tue, 22 May 2001 14:11:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262700AbREVSL2>; Tue, 22 May 2001 14:11:28 -0400
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
To: hpa@transmeta.com (H. Peter Anvin)
Date: Tue, 22 May 2001 19:08:15 +0100 (BST)
Cc: Martin.Knoblauch@TeraPort.de (Martin.Knoblauch),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B0A99E7.467CE534@transmeta.com> from "H. Peter Anvin" at May 22, 2001 09:55:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152GZr-0002GU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - you would need a utility with root permission to analyze the cpuid
> > info. The
> >   cahce info does not seem to be there in clear ascii.
> 
> Bullsh*t.  /dev/cpu/%d/cpuid is supposed to be mode 444 (world readable.)

Yep. cpuid is not priviledged. There are almost no cases you would want it to
be and no cpu support for that anyway.

You would need to be root to ident some non intel processors like the 486SLC
where you need to do io port access to ports 0x22/23 (from memory)
