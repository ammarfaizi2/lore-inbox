Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRKRPBO>; Sun, 18 Nov 2001 10:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRKRPBE>; Sun, 18 Nov 2001 10:01:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6149 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279798AbRKRPAt>; Sun, 18 Nov 2001 10:00:49 -0500
Subject: Re: [PATCH] moving F0 0F bug check to bugs.h
To: davej@suse.de (Dave Jones)
Date: Sun, 18 Nov 2001 15:07:56 +0000 (GMT)
Cc: zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.30.0111181512230.29315-100000@Appserv.suse.de> from "Dave Jones" at Nov 18, 2001 03:18:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165TY4-0003Ui-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We only check for the bug once so we might as well move it to check
> > the boot cpu only in bugs.h.
> 
> Whilst not an ideal solution, some people do silly things like
> putting a P150 and a P166 clocked to 150 into SMP boxes.
> It could be possible for 1 CPU to have the bug whilst another doesn't.

Perhaps we should add the bugs as bit flags to the capability masks - but
inverted (ie "no foof bug" etc) that way they'll come out with the rest of
the SMP bug handling logic
