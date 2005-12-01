Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVLACgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVLACgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVLACgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:36:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13574 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751367AbVLACgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:36:19 -0500
Date: Thu, 1 Dec 2005 03:36:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       zippel@linux-m68k.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 25/43] Create ktimeout.h and move timer.h code into it
Message-ID: <20051201023619.GU31395@stusta.de>
References: <20051130231140.164337000@tglx.tec.linutronix.de> <1133395428.32542.468.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133395428.32542.468.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:03:48AM +0100, Thomas Gleixner wrote:
> plain text document attachment (ktimeout-h.patch)
> - introduce ktimeout.h and move the timeout implementation into it, as-is.
> - keep timer.h for compatibility
>...

If you do this, you should either immediately remove timer.h or add a 
#warning to this file.

Both cases imply changing all in-kernel users (which is anyway a good 
idea if we really want to rename this header).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

