Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbULBG5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbULBG5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbULBG5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:57:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:20644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbULBG5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:57:00 -0500
Date: Wed, 1 Dec 2004 22:56:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maneesh@in.ibm.com, akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Message-ID: <20041201225659.X2357@build.pdx.osdl.net>
References: <200412020641.iB26f8W26315@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200412020641.iB26f8W26315@adam.yggdrasil.com>; from adam@yggdrasil.com on Wed, Dec 01, 2004 at 10:41:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam J. Richter (adam@yggdrasil.com) wrote:
> -static int create_dir(struct kobject * k, struct dentry * p,
> -		      const char * n, struct dentry ** d)
> +static int create_dir(void *element, struct dentry * p,
> +		      const char * n, struct dentry ** d, int type)

Hmm, I did not look closely, but moving from well-typed to untyped void *
doesn't look nice.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
