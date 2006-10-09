Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932969AbWJIQsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWJIQsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932976AbWJIQsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:48:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932969AbWJIQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:48:42 -0400
Date: Mon, 9 Oct 2006 09:48:20 -0700
From: Greg KH <gregkh@suse.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix error handling in create_files()
Message-ID: <20061009164820.GA22630@suse.de>
References: <20061009164017.GA13698@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009164017.GA13698@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 06:40:17PM +0200, Luca Tettamanti wrote:
> Hello,
> current code in create_files() detects an error iff the last
> sysfs_add_file fails:
> 
> for (attr = grp->attrs; *attr && !error; attr++) {
>         error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
> }
> if (error)
>         remove_files(dir,grp);
> 
> In order to do the proper cleanup upon failure 'error' must be checked on
> every iteration.

But it is, look up there in the "!error" test, right?

thanks,

greg k-h
