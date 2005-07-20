Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVGUCNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVGUCNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 22:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVGUCNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 22:13:35 -0400
Received: from [216.208.38.107] ([216.208.38.107]:10378 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261501AbVGUCNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 22:13:34 -0400
Subject: Re: [PATCH] Preserve hibenate-system-image on startup
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42DE2D51.5090105@sm.sony.co.jp>
References: <42D9FA0C.3060609@sm.sony.co.jp>
	 <1121619485.13487.11.camel@localhost>  <42DE2D51.5090105@sm.sony.co.jp>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121873123.6689.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Jul 2005 01:25:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-20 at 20:54, Hiroyuki Machida wrote:
> Hi,
> 
> 
> With this function, system needs to mount read-write file systems on
> every boot cycle, due to avoid inconsistency between FS and memory.
> How did you address this problem? Did kernel check RW FS remained as
> mounted on boot up or hibernate time ?

You're right. We don't seek to address this problem, just document
clearly that filesystems in use when creating the image need to be
mounted readonly. You can of course mount another filesystem read/write
while the system is up.

> I think I need to discuss with you at San Jose at the beginning of 
> this year.

Yes, I think we did meet. Nice to talk to you again.

Regards,

Nigel

> 
> Regards,
> Hiroyuki Machida
> 
> Nigel Cunningham wrote:
> > Hi.
> > 
> > We've had this feature in Suspend2 for a couple of years and I can
> > confirm that the approach works, provided that the on-disk filesystem
> > remains unchanged throughout this. (Useful mainly for kiosks etc).
> > 
> > This is not to say that I've reviewed the code below for correctness.
> > 
> > Regards,
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

