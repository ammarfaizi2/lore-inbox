Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTH2O1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTH2O1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:27:17 -0400
Received: from mail.zmailer.org ([62.240.94.4]:10426 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261252AbTH2O1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:27:16 -0400
Date: Fri, 29 Aug 2003 17:27:14 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 -> ext3 on the fly?
Message-ID: <20030829142714.GY16395@mea-ext.zmailer.org>
References: <20030829141619.GA12564@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829141619.GA12564@rdlg.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:16:19AM -0400, Robert L. Harris wrote:
> I have a number of servers which are currently mounting /usr as ext2.  I 
> have a means of doing an tune2fs -j on all of them remotely en mass but
> I'd rather not reboot them all to enable journaling on machines that are
> up and not having issues.  I've tried to do a:
> 
> mount -t ext3 -o remount /usr
> as well as just a mount -o remount after changing the fstab.

  No, the 'remount' does not work for this.
  I have done this type of upgrade myself, but I had to unmount
  and then remount filesystems.

> on a test box but it just blows out a usage message.  Is there a way to
> do this remount without a complete reboot that'll be transparant to
> users?

  No.
 
> If not, is it dangerous to tune2fs the filesystems, change the fstab and
> then leave the box up for 2-6 months and let them reboot through
> atrrition, upgrades, etc?

  In one instance I had considerable difficulties to get the box up.
  Or rather it probably came up, but claimed bogously in mtab  having
  been mounted as  ext2,  while it in reality was ext3.

  You might want to run fsck on the filesystems anyway.

> Current kernel is 2.4.21-ac3, getting outages and upgrades is a rather
> long process involving regression testing, etc.

  Invisible upgrade isn't possible, unfortunately.

> Robert
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B

/Matti Aarnio
