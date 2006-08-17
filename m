Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWHQPE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWHQPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWHQPE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:04:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61958 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965111AbWHQPE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:04:57 -0400
Date: Thu, 17 Aug 2006 15:04:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Neil Brown <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [patch] raid1: allow user to force reads from a specific disk
Message-ID: <20060817150419.GC5950@ucw.cz>
References: <200608062018_MC3-1-C74D-B4E9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608062018_MC3-1-C74D-B4E9@compuserve.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Allow user to force raid1 to read all data from a given disk.
> This lets users do integrity checking by comparing results
> from reading different disks.  If at any time the system finds
> it cannot read from the given disk it resets the disk number
> to -1, the default, which means to balance reads.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Using /sysfs as an interface... so that two utilities checking disk
integrity will interfere with each other and integrity check will
interfere with normal work. Perhaps ioctl/fcntl and per-fd status is
would be right thing to do?

-- 
Thanks for all the (sleeping) penguins.
