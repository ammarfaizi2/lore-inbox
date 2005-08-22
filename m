Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVHVV4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVHVV4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVHVV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:56:03 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9348 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751282AbVHVVzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:55:11 -0400
Date: Mon, 22 Aug 2005 13:57:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: dev-etrax <dev-etrax@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cris: "extern inline" -> "static inline"
Message-ID: <20050822115724.GJ5726@stusta.de>
References: <BFECAF9E178F144FAEF2BF4CE739C66803297EF0@exmail1.se.axis.com> <BFECAF9E178F144FAEF2BF4CE739C66801B764F8@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B764F8@exmail1.se.axis.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 07:08:30AM +0200, Mikael Starvik wrote:

> At the time this is rejected because GCC 3.2 makes other inlining
> descisions when "extern inline" is used instead of "static inline".
> Actually we modified lots of static inline to extern inline in
> 2.4 in November 2002 to reduce code bloat with GCC 3.2. I don't
> know if this still is true with 4.0. 
>...

If you look at include/linux/compiler-gcc3.h, you see that in the 
kernel, we #define "inline" to "inline __attribute__((always_inline))"
for gcc >= 3.1 .

In November 2002, we didn't do this in 2.4 kernels.

Can you test whether my patch makes any difference in the size of a 2.6 
kernel with gcc 3.2?

> /Mikael
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

