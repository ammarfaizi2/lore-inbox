Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbULQAto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbULQAto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbULQAtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:49:43 -0500
Received: from mailfe08.swip.net ([212.247.154.225]:54706 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S262411AbULQAro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:47:44 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: [PATCH] debugfs for 2.6.10-rc3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041216213645.GA9710@kroah.com>
References: <20041216213645.GA9710@kroah.com>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 01:47:39 +0100
Message-Id: <1103244459.1197.15.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 13:36 -0800, Greg KH wrote:
> I've added debugfs to my bk driver tree (located at
> bk://kernel.bkbits.net/gregkh/linux/driver-2.6) so it will show up in
> the next -mm release.  For those who want to see the patch version, or
> want to put it in any other kernel tree (Fedora perhaps?) I've included
> it below.  I haven't added the kobject interface yet, I'll try to get to
> that next week.
> 
> thanks,
> 
> greg k-h
> 
> ----------------------------
> 
> debugfs: add debugfs
> 
> debugfs is a filesystem that is just for debug data.
> Start moving stuff out of proc and sysfs now :)

Hi Greg

Is there any reason why this shouldn't be buildable as module? I saw no
apparent reason and added "|| defined(MODULE)" to debugfs.h and made the
Kconfig option tristate. This allowed it to be built as a working module
(yay, i didn't have to restart to try it out!).

Also I saw there was no debugfs_create_u64() for us on 64bit machines ;)


Thanks
Alexander

