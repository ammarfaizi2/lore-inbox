Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTFLWHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTFLWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:07:39 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:4107 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265023AbTFLWHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:07:35 -0400
Date: Fri, 13 Jun 2003 00:23:38 +0200
From: Jerome Chantelauze <jerome.chantelauze@finix.eu.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc8
Message-ID: <20030612222338.GC25637@i486X33>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:06:15PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -rc8. If nothing really bad happens in 2 days, this becomes
> final.

Hi,

-rc8 with "Old hard disk (MFM/RLL/IDE) driver" still doesn't build.

Does it mean that the old ide driver will not be available anymore and
that 2.4.21 will not run on some older computers ? 

Using the new driver will not help on some older computers. I gave it a
try, and at least one of my computers have serious timing problems with
the new (enhanced) ide driver.

I try again to send a (trivial) patch to fix this. Please, Marcello,
consider including it. Anyway, it can't break anything.

If you reject it, please give me a chance to improve it, and tell me
why.

---------
*** drivers/ide/Makefile.orig   Thu Jun 12 23:37:49 2003
--- drivers/ide/Makefile        Thu Jun 12 23:40:15 2003
***************
*** 54,59 ****
--- 54,60 ----
    obj-y               += arm/idedriver-arm.o
  else
    ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
+       subdir-$(CONFIG_BLK_DEV_HD_ONLY) += legacy
        obj-y   += legacy/idedriver-legacy.o
    endif
  endif
---------

Regards.
--
Jerome Chantelauze
