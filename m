Return-Path: <linux-kernel-owner+w=401wt.eu-S964857AbXASTPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbXASTPy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbXASTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:15:53 -0500
Received: from xenotime.net ([66.160.160.81]:56188 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964857AbXASTPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:15:53 -0500
Date: Fri, 19 Jan 2007 11:12:09 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Noah Watkins <nwatkins@ittc.ku.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include linux/fs.h in linux/cdev.h for struct inode
Message-Id: <20070119111209.ab02d109.rdunlap@xenotime.net>
In-Reply-To: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
References: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
Organization: YPO4
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007 12:54:07 -0600 Noah Watkins wrote:

> ---
>  include/linux/cdev.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> index f309b00..b53e2a0 100644
> --- a/include/linux/cdev.h
> +++ b/include/linux/cdev.h
> @@ -5,6 +5,7 @@
>  #include <linux/kobject.h>
>  #include <linux/kdev_t.h>
>  #include <linux/list.h>
> +#include <linux/fs.h>
>  
>  struct cdev {
>  	struct kobject kobj;
> -- 

You can just do this forward declaration instead:

struct inode;

since no struct members are used/needed.

This cuts down on #include spider webs & nests.

---
~Randy
