Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbULCFTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbULCFTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 00:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbULCFTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 00:19:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:15236 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261917AbULCFTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 00:19:39 -0500
Date: Thu, 2 Dec 2004 21:19:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maneesh@in.ibm.com, akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Message-ID: <20041202211932.I2357@build.pdx.osdl.net>
References: <200412030250.iB32oZQ02969@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200412030250.iB32oZQ02969@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Dec 02, 2004 at 06:50:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam J. Richter (adam@yggdrasil.com) wrote:
> 	sysfs_dir_close did not free the "cursor" sysfs_dirent
> used for keeping track of position in the list of sysfs_dirent nodes.
> Consequently, doing a "find /sys" would leak a sysfs_dirent for
> each of the 1140 directories in my /sys tree, or about 36kB
> each time.

Yeah, I noticed this as well.  Why the BUGON()?

thanks,
-chris
