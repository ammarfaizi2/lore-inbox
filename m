Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTD2HMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 03:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTD2HMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 03:12:39 -0400
Received: from granite.he.net ([216.218.226.66]:32014 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261985AbTD2HMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 03:12:36 -0400
Date: Tue, 29 Apr 2003 00:26:08 -0700
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] 30 potential dereference of user-pointer errors
Message-ID: <20030429072608.GB4616@kroah.com>
References: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 07:18:02PM -0700, Junfeng Yang wrote:
> [BUG] pointer (rdwr_arg.msgs[i]) points to user space
> /home/junfeng/linux-tainted/drivers/i2c/i2c-dev.c:230:i2cdev_ioctl: ERROR:TAINTED:230:230: dereferencing tainted ptr 'rdwr_arg.msgs + i * 12' [Callstack: ]
> 
> 			if(rdwr_pa[i].buf == NULL)
> 			{
> 				res = -ENOMEM;
> 				break;
> 			}
> 
> Error --->
> 			if(copy_from_user(rdwr_pa[i].buf,
> 				rdwr_arg.msgs[i].buf,
> 				rdwr_pa[i].len))
> 			{

This one should be already be fixed in the 2.5.68 kernel.

thanks,

greg k-h
