Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTIBMoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbTIBMoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:44:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53215 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261504AbTIBMn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:43:56 -0400
Date: Mon, 1 Sep 2003 16:06:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Benjamin C. Ling" <bling@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to inject memory bitflips for maximum damage?
Message-ID: <20030901140654.GE1358@openzaurus.ucw.cz>
References: <Pine.LNX.4.44.0308231439040.19230-100000@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308231439040.19230-100000@Xenon.Stanford.EDU>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We have FAUmachine (a linux-based fault-injection VM) installed and
> running on our research cluster, and can inject memory-bitflips in our
> processes running on top of FAUmachine.
> 
> My question is -- how do I find out where to inject the bitflip for
> maximum damage (or even any damage at all).  I've done a bit of searching
> on google but haven't come up with much.
> 
> If anyone has any insight on where linux holds its critical memory
> structures, or where it places its running programs in physical memory,
> could you please let me know?  

Toggle some bit in kernel code... That should
kill it real soon. Look at System.map for some
good places. (do_irq?). Substract 0xC0000000 for
physical address.

BTW what is purpose of these experiments?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hi!

> We have FAUmachine (a linux-based fault-injection VM) installed and
> running on our research cluster, and can inject memory-bitflips in our
> processes running on top of FAUmachine.
> 
> My question is -- how do I find out where to inject the bitflip for
> maximum damage (or even any damage at all).  I've done a bit of searching
> on google but haven't come up with much.
> 
> If anyone has any insight on where linux holds its critical memory
> structures, or where it places its running programs in physical memory,
> could you please let me know?  

Toggle some bit in kernel code... That should
kill it real soon. Look at System.map for some
good places. (do_irq?). Substract 0xC0000000 for
physical address.

BTW what is purpose of these experiments?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

