Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132151AbRDPVTJ>; Mon, 16 Apr 2001 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRDPVTA>; Mon, 16 Apr 2001 17:19:00 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132144AbRDPVSs>;
	Mon, 16 Apr 2001 17:18:48 -0400
Date: Mon, 16 Apr 2001 15:32:18 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
Message-ID: <20010416153216.C40@(none)>
In-Reply-To: <3AD622AB.5F0A061B@linux-ide.org> <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Apr 12, 2001 at 02:52:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> /*
>  * Timeouts for various operations:
>  */
> #define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms */
> #ifdef CONFIG_APM
> #define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */

Broken broken broken. CONFIG_APM has *nothing* to do with machine being laptop.
Think ACPI, think mips handheld. You should assume 5seconds, always.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

