Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVAKUdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVAKUdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVAKUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:33:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:32981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262155AbVAKUd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:33:27 -0500
Date: Tue, 11 Jan 2005 12:33:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org, lorenzo@gnu.org
Subject: Re: [PATCH] Trusted Path Execution LSM 0.2 (20050108)
Message-ID: <20050111123320.S469@build.pdx.osdl.net>
References: <20050111195542.76809.qmail@web50605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111195542.76809.qmail@web50605.mail.yahoo.com>; from linux_4ever@yahoo.com on Tue, Jan 11, 2005 at 11:55:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steve G (linux_4ever@yahoo.com) wrote:
> This patch leaks memory in the error paths. For example: 
> 
> +static ssize_t trustedlistadd_read_file(struct tpe_list *list, char *buf)
> +{
> <snip>
> + char *buffer = kmalloc(400, GFP_KERNEL);
> +
> + user = (char *)__get_free_page(GFP_KERNEL);
> + if (!user)
> + return -ENOMEM;

Helps to inform the author ;-)

-chris
