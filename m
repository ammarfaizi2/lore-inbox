Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRCCNQV>; Sat, 3 Mar 2001 08:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCCNQL>; Sat, 3 Mar 2001 08:16:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33546 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130454AbRCCNP7>; Sat, 3 Mar 2001 08:15:59 -0500
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen similar problem on PPC
To: dsiebert@divms.uiowa.edu (Doug Siebert)
Date: Sat, 3 Mar 2001 13:18:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103030422.WAA27608@server.divms.uiowa.edu> from "Doug Siebert" at Mar 02, 2001 10:22:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZBvk-0003XK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> barn.  You will need to request a getnanotimeofday() be created if you
> want to allow two consecutive calls to always return different values
> (modulo SMP systems and ~13 more years of Moore's Law)

Or you use rdtsc instructions for x86. There intel do guarantee that no two
rdtsc's execute in parallel on the same cpu and it counts in cpu clocks.

Unfortunately rdtsc is only on newer x86 cpus and not useful in some smp
configurations

