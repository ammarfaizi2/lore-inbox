Return-Path: <linux-kernel-owner+w=401wt.eu-S964860AbXASUEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXASUEj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 15:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbXASUEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 15:04:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:53328 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbXASUEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 15:04:39 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UIU9b54PYaEMWHzTo9xN7Wyqn4D244pf1xLQYMRHtc7w3nJUp//z1oLBowOnjrYJoivRC/JjeC0GwifMDGM8Xhqe6CutejtExfQ//Nlnjt1nUKVPAObBSI//qqlCk1ygvoC+kI2aXumdIiW+3poZ3I3ulklDeWY2NAVtQB71ITE=
Date: Fri, 19 Jan 2007 23:04:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Noah Watkins <nwatkins@ittc.ku.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include linux/fs.h in linux/cdev.h for struct inode
Message-ID: <20070119200418.GA5013@martell.zuzino.mipt.ru>
References: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11692328473797-git-send-email-nwatkins@ittc.ku.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 12:54:07PM -0600, Noah Watkins wrote:
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

It is not for "struct inode", but to a pointer to struct inode!
You don't need full-blown header for pointer.

