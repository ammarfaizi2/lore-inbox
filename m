Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRCVWvt>; Thu, 22 Mar 2001 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRCVWv3>; Thu, 22 Mar 2001 17:51:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19978 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132224AbRCVWvV>; Thu, 22 Mar 2001 17:51:21 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: dwguest@win.tue.nl (Guest section DW)
Date: Thu, 22 Mar 2001 22:52:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stephenc@theiqgroup.com (Stephen Clouse),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010322230041.A5598@win.tue.nl> from "Guest section DW" at Mar 22, 2001 11:00:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gDwB-0003Tj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Eventually you have to kill something or the machine deadlocks.
> 
> Alan, this is a fake argument.

No it is not.

> You see, the bug is that malloc does not fail. This means that the
> decisions about what to do are not taken by the program that knows
> what it is doing, but by the kernel.

Even if malloc fails the situation is no different. You can do 
overcommit avoidance in Linux if you are bored enough to try it. I did it
in 1.2 one afternoon when bored. You simply account address space. Almost
everything you need to touch is in mm/*.c and localised. The only exception
is ptrace.

