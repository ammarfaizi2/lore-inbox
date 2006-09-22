Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWIVUQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWIVUQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWIVUQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:16:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964889AbWIVUQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:16:54 -0400
Date: Fri, 22 Sep 2006 13:16:37 -0700
From: Greg KH <greg@kroah.com>
To: Ed Swierk <eswierk@arastra.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [RETRY] [PATCH] load_module: no BUG if module_subsys uninitialized
Message-ID: <20060922201637.GA17547@kroah.com>
References: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:48:48PM -0700, Ed Swierk wrote:
> [I discovered after sending my previous message that Gmail helpfully
> line-wrapped and de-tabified my patch. I'm resending it as an
> attachment; apologies for the error.]
> 
> Invoking load_module() before param_sysfs_init() is called crashes in
> mod_sysfs_setup(), since the kset in module_subsys is not initialized
> yet.

How are you calling load_module before this init call is made?

thanks,

greg k-h
