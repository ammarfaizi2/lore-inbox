Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCVIwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCVIwE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWCVIwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:52:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751119AbWCVIwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:52:01 -0500
Date: Wed, 22 Mar 2006 00:48:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060322004843.4c6036e8.akpm@osdl.org>
In-Reply-To: <20060322094136.47b12335@werewolf.auna.net>
References: <20060318044056.350a2931.akpm@osdl.org>
	<20060322094136.47b12335@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Sat, 18 Mar 2006 04:40:56 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/
> > 
> > 
> > - John's time rework patches were dropped - they're being reworked.
> > 
> > - Lots of MD and DM updates
> > 
> 
> Mmmm, somthing strange is in this kernel. Is hangs the box in the middle
> of the night, it looks like it got stuck on the scsi disk on an AHC
> controller...I get no info on syslog.
> 
> Are there any changes in aic drivers ? It also has a raid array, perhaps
> some change in md code is borking when cron jobs are run in the night...

diffstat will tell.

 b/drivers/scsi/aic7xxx/aic79xx_core.c      |   33 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c       |  559 
 b/drivers/scsi/aic7xxx/aic79xx_osm.h       |    7 
 b/drivers/scsi/aic7xxx/aic7xxx_core.c      |   24 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c       |   45 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.h       |    5 

There are large numbers of changes to scsi core as well.  And MD.  And
everything else.

Can no info be obtained from sysrq-P or sysrq-T?

If it's running X then I'd suggest you quit from X overnight, see if
anything pops up on the screen, and to simplify using sysrq.
