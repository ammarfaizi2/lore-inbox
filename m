Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSELUx7>; Sun, 12 May 2002 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSELUx6>; Sun, 12 May 2002 16:53:58 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:62544 "EHLO
	tsmtp5.mail.isp") by vger.kernel.org with ESMTP id <S315420AbSELUx5>;
	Sun, 12 May 2002 16:53:57 -0400
Date: Sun, 12 May 2002 22:57:24 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
Message-Id: <20020512225724.232357b3.DiegoCG@teleline.es>
In-Reply-To: <20020512203615.A12612@averell>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 20:36:15 +0200
Andi Kleen <ak@muc.de> escribió:

> 
> This patch make CONFIG_ISA an configuration option for i386. This makes
> sense considering that most PCs do not ship with ISA slots anymore.

Sorry for my ignorance, but the typical conectors: mouse, keyboard, /dev/ttyS0, /dev/ttyS1, /dev/lp0...aren't isa devices?


> 
> The ISA drivers are often old and unmaintained, this way one can easier
> ignore them.
> 
> It also makes some more drivers dependent on CONFIG_ISA, mostly
> in drivers/scsi and sound. I did this by looking at the source code
> and double checked the result with linux-kernel.
> 
> VLB only drivers are also included in CONFIG_ISA, under the assumption
> that VLB boxes always have ISA slots. 
> 
> The configuration changes are not complete, some subsystems are missing
> like ISDN. I'm hoping the maintainers will add it there too.
> 
> The main motivation is that I can turn off CONFIG_ISA for x86-64 where
> no ISA slots exist. The ISA drivers are often not 64bit safe and compile
> with an incredible number of warnings only.
> 
> Patch for 2.5.15. 
> 
> -Andi
