Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVBXRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVBXRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVBXRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:33:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:6341 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262428AbVBXRdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:33:03 -0500
Date: Thu, 24 Feb 2005 09:32:54 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] CKRM [1/8]  Base CKRM events, mods to existing kernel code
Message-ID: <20050224173254.GA10086@kroah.com>
References: <E1D4FNZ-0006vj-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4FNZ-0006vj-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:33:53AM -0800, Gerrit Huizenga wrote:
> Core CKRM Event Callbacks.

I could wait 3 months with my comments like you did with your reply, but
I think I'll be a bit more timely, as I hope that you will be next time.

> On exec, fork, exit, real/effective gid/uid, use CKRM to associate
> tasks with appropriate class.
> 
> Addressed review comments:
> 
> Sam Ravnborg:  Use Makefile syntax correctly
> Dave Hansen:  Use of ## is annoying
> Greg KH:  Remove Changelogs;
>         Use __KERNEL__ correctly (if at all);
>         Consolidate CONFIG_ sections in header files;
>         Fix extern int get_exe_path_name().
>         Remove unused DEBUG code 
>         Convert enum to typedef in prep for sparce __bitwise use
> 
> Not yet Addressed:
> 
> Greg KH:
>         Use of __bitwise and sparse in enum's
>         Use of kernel list type

You forgot:
	Fix coding style
	Fix mix of whitespace (tabs and spaces)

Which you said you fixed up, but according to the code, you didn't :(

Also please add:
	Use kref instead of atomic counters
	Address Greg's comments about the fs.

I'll wait for these things to all get fixed up before reviewing the code
again.

thanks,

greg k-h
